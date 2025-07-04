//
//  SwiftUIView.swift
//  Wavify
//
//  Created by Apple on 03/07/25.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        
        
        VStack() {
            HStack {
                Button(action: {
                    
                }) {
                    Image(systemName: "chevron.backward")
                        .padding(.horizontal, 16)
                        .tint(.white)
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.down")
                        .padding(.horizontal, 16)
                        .tint(.white)
                }
            }
            .padding(.bottom, 20)
            
            VStack() {
                Image(.sampleArtwork)
                    .resizable()
                    .cornerRadius(8)
                    .frame(height: 300, alignment: .center)
                    .padding(.horizontal, 15)
                
                Text("Ishq Bawla Coke Studio Bharat - Sigle")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 0)
                
                Text("Dhandha Nyoliwala & Xvir Grewal")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .multilineTextAlignment(.center)

                
            }
            .padding(.horizontal, 35)
            
            Spacer()
        }
        .background(.backgroundPrimary)
    }
}

#Preview {
    DetailView()
}
