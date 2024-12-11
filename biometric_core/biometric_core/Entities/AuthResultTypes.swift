//
//  AuthResultTypes.swift
//  biometric_core
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 09/12/24.
//

import Foundation

class BiometricAuthResultType {
    let id: Int
    let message: String?

    init(id: Int = 0, message: String?) {
        self.id = id
        self.message = message
    }

    func toMap() -> [String: Any?] {
        return [
            "id": id,
            "message": message,
        ]
    }
}

// This case can be returned both by `canAuthenticate()` and `authenticate()`
// methods. Thus, it is used to represent two scenarios:
// - The biometric feature is ready to be used on the device.
// - The user has successfully authenticated using biometric feature.
class AuthSuccess: BiometricAuthResultType {
    init() {
        super.init(id: 1, message: "Successfully authenticated using biometric feature")
    }
}

// The app canceled authentication.
class AuthAppCancel: BiometricAuthResultType {
    init() {
        super.init(id: -2, message: "The app canceled authentication")
    }
}

// The system canceled authentication.
class AuthSystemCancel: BiometricAuthResultType {
    init() {
        super.init(id: -2, message: "The system canceled authentication")
    }
}

// The user tapped the cancel button in the authentication dialog.
class AuthUserCancel: BiometricAuthResultType {
    init() {
        super.init(id: -2, message: "The user tapped the cancel button in the authentication dialog")
    }
}

// Biometry is locked because there were too many failed attempts.
class AuthBiometryLockout: BiometricAuthResultType {
    init() {
        super.init(id: -1, message: "Biometry is locked because there were too many failed attempts")
    }
}

// Biometry is not available on the device.
class AuthBiometryNotAvailable: BiometricAuthResultType {
    init() {
        super.init(id: -7, message: "Biometry is not available on the device")
    }
}

// The user has no enrolled biometric identities.
class AuthBiometryNotEnrolled: BiometricAuthResultType {
    init() {
        super.init(id: -6, message: "The user has no enrolled biometric identities")
    }
}

// Touch ID is locked because there were too many failed attempts.
// Used only in iOS 9.0–11.0. Replaced by biometryLockout.
class AuthTouchIDLockout: BiometricAuthResultType {
    init() {
        super.init(id: -1, message: "Touch ID is locked because there were too many failed attempts")
    }
}

// Touch ID is not available on the device.
// Used only in iOS 8.0–11.0. Replaced by biometryNotAvailable.
class AuthTouchIDNotAvailable: BiometricAuthResultType {
    init() {
        super.init(id: -7, message: "Touch ID is not available on the device")
    }
}

// The user has no enrolled Touch ID fingers.
// Used only in iOS 8.0–11.0. Replaced by biometryNotEnrolled.
class AuthTouchIDNotEnrolled: BiometricAuthResultType {
    init() {
        super.init(id: -6, message: "The user has no enrolled Touch ID fingers")
    }
}

// The user failed to provide valid credentials.
class AuthAuthenticationFailed: BiometricAuthResultType {
    init() {
        super.init(id: -2, message: "The user failed to provide valid credentials")
    }
}

// The context was previously invalidated.
class AuthInvalidContext: BiometricAuthResultType {
    init() {
        super.init(id: -2, message: "")
    }
}

// Displaying the required authentication user interface is forbidden.
class AuthNotInteractive: BiometricAuthResultType {
    init() {
        super.init(id: -5, message: "Displaying the required authentication is forbidden")
    }
}

// A passcode isn’t set on the device.
class AuthPasscodeNotSet: BiometricAuthResultType {
    init() {
        super.init(id: -1, message: "A passcode isn't set on the device")
    }
}

// The user tapped the fallback button in the authentication dialog, but no
// fallback is available for the authentication policy.
class AuthUserFallback: BiometricAuthResultType {
    init() {
        super.init(id: -1, message: "")
    }
}

// An unknown error has occurred.
class AuthUnknownStatus: BiometricAuthResultType {
    init() {
        super.init(id: -3, message: "An unknown error has occurred")
    }
}
