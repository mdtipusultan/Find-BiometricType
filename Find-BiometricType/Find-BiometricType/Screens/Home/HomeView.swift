//
//  HomeView.swift
//  Find-BiometricType
//
//  Created by Tipu on 13/9/24.
//

import SwiftUI
import LocalAuthentication

struct HomeView: View {
    
    @State private var biometricType: BiometricType = .none
    @State private var message: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if biometricType == .faceID {
                Button(action: {
                    authenticateUser() // Authenticate on Face ID tap
                }) {
                    Image(systemName: "faceid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            } else if biometricType == .touchID {
                Button(action: {
                    authenticateUser() // Authenticate on Touch ID tap
                }) {
                    Image(systemName: "touchid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            } else {
                Text("Biometrics not available")
            }
            
            // Display a message with authentication results
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.blue)
            }
        }
        .onAppear {
            biometricType = getBiometricType()
        }
    }
    
    func getBiometricType() -> BiometricType {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch context.biometryType {
            case .faceID:
                return .faceID
            case .touchID:
                return .touchID
            default:
                return .none
            }
        }
        return .none
    }
    
    // Biometric Authentication function
    func authenticateUser() {
        let context = LAContext()
        let reason = "Authenticate to access this feature"
        
        // Check if the device supports biometric authentication
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                    message = "Authentication successful!"
                } else {
                    message = "Authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")"
                }
            }
        }
    }
}

enum BiometricType {
    case none
    case touchID
    case faceID
}

#Preview {
    HomeView()
}
