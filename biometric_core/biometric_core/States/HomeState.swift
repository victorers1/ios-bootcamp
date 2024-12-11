// This is the Model layer of the HomePage

import Foundation

struct HomeState {
    var hasBiometricHardware: Bool?
    var enrolledBiometrics: [String]
    var canAuthenticate: String?
    var authenticationResult: String?
    var authenticationWithCredentialsResult: String?
    var authenticationWithTimeoutResult: String?
    var stopAuthentication: Bool?
    var enrollPromptOpened: Bool?
}
