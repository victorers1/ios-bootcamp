//
//  ContentView.swift
//  biometric_core
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 29/10/24.
//

import LocalAuthentication
import SwiftUI

struct HomeView: View {
    @StateObject private var homeStore = HomeStore()

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                
                Spacer().frame(height: 1)
                
                FeatureSection(
                    title: "Device has biometric hardware?\n\(homeStore.homeState.hasBiometricHardware ?? false)",
                    buttonText: "Refresh",
                    onTapButton: homeStore.hasBiometricHardware
                )

                FeatureSection(
                    title: "Can I try to authenticate?\n\(homeStore.homeState.canAuthenticate ?? "")",
                    buttonText: "Refresh",
                    onTapButton: homeStore.canAuthenticate
                )

                FeatureSection(
                    title: "What are the authentication options?\n\(homeStore.homeState.enrolledBiometrics)",
                    buttonText: "Refresh",
                    onTapButton: homeStore.getEnrolledBiometrics
                )

                FeatureSection(
                    title: "Enroll to biometry:\n\(homeStore.homeState.enrollPromptOpened ?? false)",
                    buttonText: "Enroll",
                    onTapButton: homeStore.enrollToBiometry
                )

                FeatureSection(
                    title: "Biometric only Authentication:\n\(homeStore.homeState.authenticationResult ?? "")",
                    buttonText: "Authenticate",
                    onTapButton: {
                        homeStore.authenticateWithBiometryOnly(timeout: nil)
                    }
                )

                FeatureSection(
                    title: "Authentication with fallback to credentials:\n\(homeStore.homeState.authenticationWithCredentialsResult ?? "")",
                    buttonText: "Authenticate",
                    onTapButton: homeStore.authenticateWithCredentials
                )

                FeatureSection(
                    title: "Authentication with timeout:\n\(homeStore.homeState.authenticationWithTimeoutResult ?? "")",
                    buttonText: "Authenticate",
                    onTapButton: {
                        homeStore.authenticateWithBiometryOnly(timeout: 3)
                    }
                )

                FeatureSection(
                    title: "You can stop an authentication at any time:\n\(homeStore.homeState.stopAuthentication ?? false)",
                    buttonText: "Stop authentication",
                    onTapButton: homeStore.stopAuthentication
                )
                
                Spacer().frame(width: 1)
            }
            .padding()
        }.onAppear(perform: {
            homeStore.hasBiometricHardware()
            homeStore.canAuthenticate()
        })
    }
}

#Preview {
    HomeView()
}
