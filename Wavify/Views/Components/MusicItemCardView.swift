//
//  MusicItemCardView.swift
//  Wavify
//
//  Created by Apple on 30/06/25.
//

import SwiftUI
import MusicKit

struct MusicItemCardView: View {
    let item: MusicPersonalRecommendation.Item
    @State private var artistNames: [String] = []
    @State private var isLoadingArtists = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Artwork Section
            Group {
                switch item {
                case .playlist(let playlist):
                    artworkView(playlist.artwork, fallbackSymbol: "music.note.list")
                case .album(let album):
                    artworkView(album.artwork, fallbackSymbol: "square.stack")
                case .station(let station):
                    artworkView(station.artwork, fallbackSymbol: "radio")
                default:
                    artworkView(nil, fallbackSymbol: "music.note")
                }
            }
            .frame(width: 160, height: 160)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
            )
            
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title ?? "Unknown")
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                
                subtitleView()
                
                if isLoadingArtists {
                    ProgressView()
                        .scaleEffect(0.5)
                } else if !artistNames.isEmpty {
                    Text(artistNames.joined(separator: ", "))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .frame(width: 160, height: 242)
        .task {
            if case .playlist(let playlist) = item {
                await fetchArtists(for: playlist)
            }
        }
    }
    
    @ViewBuilder
    private func artworkView(_ artwork: Artwork?, fallbackSymbol: String) -> some View {
        if let artwork = artwork {
            ArtworkImage(artwork, width: 160)
                .cornerRadius(8)
        } else {
            Image(systemName: fallbackSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.secondary)
                .frame(width: 160, height: 160)
                .background(Color.gray.opacity(0.1))
        }
    }
    
    @ViewBuilder
    private func subtitleView() -> some View {
        switch item {
        case .playlist(let playlist):
            Text(playlist.curatorName ?? "Playlist")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        case .album(let album):
            Text(album.artistName ?? "Artist")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        case .station(let station):
            Text("Station")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        default:
            Text("Music")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private func fetchArtists(for playlist: Playlist) async {
        isLoadingArtists = true
        defer { isLoadingArtists = false }
        
        do {
            let detailedPlaylist = try await playlist.with([.tracks])
            let artists = detailedPlaylist.tracks?.compactMap { $0.artistName } ?? []
            let uniqueArtists = Array(Set(artists)).prefix(3)
            self.artistNames = Array(uniqueArtists)
        } catch {
            print("Error fetching playlist details: \(error)")
        }
    }
}
