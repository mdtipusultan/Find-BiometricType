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
    
    var body: some View {
        VStack {
            if biometricType == .faceID {
                Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else if biometricType == .touchID {
                Image(systemName: "touchid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                Text("Biometrics not available")
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
