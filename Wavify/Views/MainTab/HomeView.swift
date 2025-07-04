//
//  HomeView.swift
//  Wavify
//
//  Created by Apple on 30/06/25.
//

import SwiftUI
import MusicKit

struct HomeView: View {
    
    @State var recommendations: [MusicPersonalRecommendation] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            LazyVStack(alignment: .leading, spacing: 15) {

                ForEach(recommendations, id: \.id) { recommendation in
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text(recommendation.title ?? "")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.textPrimary)
                            .padding(.bottom, -8)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(recommendation.items, id: \.id) { item in
                                    MusicItemCardView(item: item)
                                }
                            }
                        }
                    }
                    
                }
            }
            .padding(.horizontal, 16)
        }
        .background(.backgroundPrimary)
        .navigationBarBackButtonHidden(true)
        .task {
            await loadRecommendations()
        }
    }
    
    
    
    
    //MARK: - Functions
    func loadRecommendations() async {
        let status = await MusicAuthorization.request()
        guard status == .authorized else { return }
        
        do {
            let request = MusicPersonalRecommendationsRequest()
            let response = try await request.response()
            
            self.recommendations = response.recommendations.map({$0})
            for recommendation in response.recommendations {
                print("📦 Category: \(recommendation.title ?? "")")
            }
            
            
            
            let recommendations = response.recommendations
            
            let stations = recommendations.reduce(into: MusicItemCollection<Station>()) { $0 += $1.stations }
            let albums = recommendations.reduce(into: MusicItemCollection<Album>()) { $0 += $1.albums }
            
            let recentleyPlayed = response.recommendations.filter {
                $0.title == "Recently Played"
            }
            
            for recentleyPlay in recentleyPlayed {
                print("Recently Played: \n", recentleyPlay)
            }
            
        } catch {
            print("Error fetching recommendations: \(error)")
        }
    }
    
}

#Preview {
    HomeView()
}
