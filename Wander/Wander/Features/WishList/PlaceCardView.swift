//
//  PlaceCardView.swift
//  Wander
//
//  Created by Jessica Jesus on 31/03/2026.
//

import SwiftUI

struct PlaceCardView: View {
    @StateObject var viewModel: PlaceCardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Image
            ZStack(alignment: .topTrailing) {
                Button {
                    withAnimation(.spring()) {
                        viewModel.remove()
                    }
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                        .padding(12)
                }
            }
            
            // MARK: - Info
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                Label(
                    "\(viewModel.city), \(viewModel.country)",
                    systemImage: "mappin.circle.fill"
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                if let note = viewModel.note, !note.isEmpty {
                    Text(note)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .padding(.top, 2)
                }
                
                Text("Added \(viewModel.addedAt.formatted(.relative(presentation: .named)))")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .padding(.top, 2)
            }
            .padding(16)
        }
        .background(Color.wanderCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
    }
    
    private var imagePlaceholder: some View {
        ZStack {
            LinearGradient(
                colors: [.wanderAccent.opacity(0.3), .wanderAccent.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 8) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.largeTitle)
                    .foregroundStyle(.white.opacity(0.8))
                Text(viewModel.city)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .frame(height: 180)
    }
}
