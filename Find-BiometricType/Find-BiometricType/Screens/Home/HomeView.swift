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
                    // Action when Face ID icon is tapped
                    message = "Face ID tapped!"
                }) {
                    Image(systemName: "faceid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            } else if biometricType == .touchID {
                Button(action: {
                    // Action when Touch ID icon is tapped
                    message = "Touch ID tapped!"
                }) {
                    Image(systemName: "touchid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            } else {
                Text("Biometrics not available")
            }
            
            // Display a message when an icon is tapped
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
}

enum BiometricType {
    case none
    case touchID
    case faceID
}

#Preview {
    HomeView()
}
