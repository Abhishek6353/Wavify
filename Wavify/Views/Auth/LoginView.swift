//
//  LoginView.swift
//  Wavify
//
//  Created by Apple on 30/06/25.
//

import SwiftUI
import MusicKit

struct LoginView: View {
    
    @State var shouldNavigateToHome: Bool = false
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack {
            Button("Continue with Apple Music") {
                Task {
                    let status = await MusicAuthorization.request()
                    
                    switch status {
                    case .authorized:
                        shouldNavigateToHome = true
                        
                    case .denied:
                        errorMessage = "You denied Apple Music access. Please enable it in Settings."
                        showAlert = true
                        
                    case .notDetermined:
                        errorMessage = "We couldn't determine Apple Music access. Please try again."
                        showAlert = true
                        
                    case .restricted:
                        errorMessage = "Apple Music access is restricted on this device."
                        showAlert = true
                        
                    @unknown default:
                        fatalError("Unhandled MusicAuthorization status")
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .foregroundStyle(.textPrimary)
            .background(.red)
            .cornerRadius(5)
            .navigationDestination(isPresented: $shouldNavigateToHome) {
                HomeView()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Access Error"), message: Text(errorMessage))
            }
        }
    }
}

#Preview {
    LoginView()
}
