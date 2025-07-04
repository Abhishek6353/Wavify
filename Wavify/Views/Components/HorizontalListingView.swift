//
//  HorizontalMediaSection.swift
//  Wavify
//
//  Created by Apple on 30/06/25.
//

import SwiftUI

struct HorizontalListingView: View {
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            Text("Recently played")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.textPrimary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<5) { _ in
                        
                        VStack(spacing: 0, content: {
                            Image("sampleArtwork")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 160)
                            
                            Text("Road Trip")
                                .foregroundStyle(.textPrimary)
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("Upbeat indie and rock")
                                .foregroundStyle(.textSecondary)
                                .font(.system(size: 14))
                            
                        })
                        .frame(width: 160, height: 242)
                    }
                }
            }
        }

    }
}

#Preview {
    HorizontalListingView()
}
