// This is the ViewModel layer of the HomePage
import Foundation
import LocalAuthentication
import UIKit

class HomeStore: ObservableObject {
    private var laContext = LAContext()
    private var localizedCancelTitle = "Give up"
    private var localizedFallbackTitle = "Use password instead"

    init() {
        setLALocalizedStrings()
    }

    @Published var homeState: HomeState = HomeState(
        hasBiometricHardware: nil,
        enrolledBiometrics: [],
        canAuthenticate: nil,
        authenticationResult: nil,
        authenticationWithCredentialsResult: nil,
        authenticationWithTimeoutResult: nil,
        stopAuthentication: nil,
        enrollPromptOpened: nil
    )

    // Biometric authentication was introduced with iOS 7 in 2013 alongside the
    // release of the iPhone 5S, which featured the first Touch ID fingerprint
    // sensor. Since then, all models have either Touch ID or Face ID.
    //
    // As this app supports iOS 15+, this is always true.
    func hasBiometricHardware() {
        if #available(iOS 7.0, *) {
            homeState.hasBiometricHardware = true
        } else {
            homeState.hasBiometricHardware = false
        }
    }

    func getEnrolledBiometrics() {
        var error: NSError?

        laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

        // This property is set only after the call of canEvaluatePolicy(_:error:)
        // method, and is set no matter what the call returns.
        let enrolledBiometric = laContext.biometryType

        switch enrolledBiometric {
        case .faceID:
            homeState.enrolledBiometrics = ["FaceID"]
        case .touchID:
            homeState.enrolledBiometrics = ["TouchID"]
        default:
            homeState.enrolledBiometrics = ["None"]
        }
    }
    
    func enrollToBiometry() {
        // TODO: perform safe call
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        homeState.enrollPromptOpened = true
    }

    func canAuthenticate() {
        var error: NSError?

        let canAuthenticate: Bool = laContext.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )

        if canAuthenticate {
            homeState.canAuthenticate = "Yes"

        } else if let safeError = error {
            homeState.canAuthenticate = getBiometricAuthResultType(safeError).message
        }
    }

    func authenticateWithBiometryOnly(timeout: Double?) {
        var resultMessage: String? = ""
        var error: NSError?
        let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics

        if laContext.canEvaluatePolicy(policy, error: &error) {
            laContext.localizedFallbackTitle = ""
            laContext.evaluatePolicy(policy, localizedReason: "This is for security reason") {
                success,
                    err in

                if success {
                    resultMessage = AuthSuccess().message
                } else if err != nil {
                    resultMessage = self.getBiometricAuthResultType(err! as NSError).message
                } else {
                    resultMessage = AuthUnknownStatus().message
                }

                DispatchQueue.main.async {
                    if timeout == nil {
                        self.homeState.authenticationResult = resultMessage
                    } else {
                        self.homeState.authenticationWithTimeoutResult = resultMessage
                    }
                }
            }
        } else {
            if let safeError = error {
                resultMessage = getBiometricAuthResultType(safeError).message
            } else {
                resultMessage = AuthUnknownStatus().message
            }

            DispatchQueue.main.async {
                if timeout == nil {
                    self.homeState.authenticationResult = resultMessage
                } else {
                    self.homeState.authenticationWithTimeoutResult = resultMessage
                }
            }
        }

        if timeout != nil {
            Timer.scheduledTimer(withTimeInterval: timeout ?? Double(3), repeats: false) { _ in
                self.stopAuthentication()
            }
        }
    }

    func authenticateWithCredentials() {
        var newState = homeState
        var error: NSError?
        let policy = LAPolicy.deviceOwnerAuthentication

        if laContext.canEvaluatePolicy(policy, error: &error) {
            laContext.localizedFallbackTitle = localizedFallbackTitle
            laContext.evaluatePolicy(policy, localizedReason: "This is for security reason") {
                success,
                    err in

                if success {
                    newState.authenticationWithCredentialsResult = "Yes"
                } else if err != nil {
                    newState.authenticationWithCredentialsResult = self.getBiometricAuthResultType(err! as NSError).message
                } else {
                    newState.authenticationWithCredentialsResult = AuthUnknownStatus().message
                }

                DispatchQueue.main.async {
                    self.homeState = newState
                }
            }
        } else {
            if let safeError = error {
                newState.authenticationWithCredentialsResult = getBiometricAuthResultType(safeError).message
            } else {
                newState.authenticationWithCredentialsResult = AuthUnknownStatus().message
            }

            DispatchQueue.main.async(execute: {
                self.homeState = newState
            })
        }
    }

    func stopAuthentication() {
        laContext.invalidate()
        laContext = LAContext()
        setLALocalizedStrings()
    }

    fileprivate func setLALocalizedStrings() {
        laContext.localizedFallbackTitle = localizedFallbackTitle
        laContext.localizedCancelTitle = localizedCancelTitle
    }

    fileprivate func getBiometricAuthResultType(_ safeError: NSError) -> BiometricAuthResultType {
        switch safeError {
        case LAError.appCancel:
            return AuthAppCancel()
        case LAError.authenticationFailed:
            return AuthAuthenticationFailed()
        case LAError.biometryLockout:
            return AuthBiometryLockout()
        case LAError.biometryNotAvailable:
            return AuthBiometryNotAvailable()
        case LAError.biometryNotEnrolled:
            return AuthBiometryNotEnrolled()
        case LAError.invalidContext:
            return AuthInvalidContext()
        case LAError.notInteractive:
            return AuthNotInteractive()
        case LAError.passcodeNotSet:
            return AuthPasscodeNotSet()
        case LAError.systemCancel:
            return AuthSystemCancel()
        case LAError.userCancel:
            return AuthUserCancel()
        case LAError.userFallback:
            return AuthUserFallback()
        default:
            return AuthUnknownStatus()
        }
    }
}
