//
//  PlaceDetailView.swift
//  Wander
//
//  Created by Jessica Jesus on 31/03/2026.
//

import SwiftUI
import MapboxMaps

struct PlaceDetailView: View {
    @StateObject var viewModel: PlaceDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.name)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        Label(
                            "\(viewModel.city), \(viewModel.country)",
                            systemImage: "mappin.circle.fill"
                        )
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(16)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Description
                    if let description = viewModel.description,
                       !description.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            sectionHeader("About", icon: "info.circle.fill")
                            Text(description)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .lineSpacing(4)
                        }
                    }
                    
                    // MARK: - Mini Mapbox Map
                    VStack(alignment: .leading, spacing: 8) {
                        sectionHeader("Location", icon: "map.fill")
                        
                        Map(viewport: .constant(.camera(
                            center: viewModel.coordinate,
                            zoom: 13,
                            bearing: 0,
                            pitch: 0
                        ))) {
                            MapViewAnnotation(coordinate: viewModel.coordinate) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(Color.wanderAccent)
                            }
                        }
                        .mapStyle(.standard)
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .disabled(true)
                    }
                    
                    // MARK: - Note
                    VStack(alignment: .leading, spacing: 8) {
                        sectionHeader("My Note", icon: "note.text")
                        
                        if viewModel.isEditingNote {
                            VStack(spacing: 8) {
                                TextEditor(text: $viewModel.note)
                                    .frame(minHeight: 80)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(.systemGray6))
                                    )
                                HStack {
                                    Spacer()
                                    Button("Cancel") {
                                        viewModel.cancelEdit()
                                    }
                                    .foregroundStyle(.secondary)
                                    
                                    Button("Save") {
                                        viewModel.saveNote()
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.wanderAccent)
                                }
                            }
                        } else {
                            Button {
                                viewModel.isEditingNote = true
                            } label: {
                                HStack {
                                    Text(viewModel.note.isEmpty ? "Add a note..." : viewModel.note)
                                        .font(.body)
                                        .foregroundStyle(
                                            viewModel.note.isEmpty ? .tertiary : .secondary
                                        )
                                        .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Image(systemName: "pencil")
                                        .foregroundStyle(Color.wanderAccent)
                                }
                                .padding(12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.systemGray6))
                                )
                            }
                        }
                    }
                    
                    // MARK: - Added date
                    Text("Added \(viewModel.addedAt.formatted(.relative(presentation: .named)))")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                    
                    // MARK: - Remove
                    Button(role: .destructive) {
                        viewModel.showingRemoveAlert = true
                    } label: {
                        Label("Remove from Wishlist", systemImage: "heart.slash.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.red.opacity(0.1))
                            )
                    }
                    .foregroundStyle(.red)
                }
                .padding(20)
            }
        }
        .ignoresSafeArea(edges: .top)
        .alert("Remove from Wishlist?", isPresented: $viewModel.showingRemoveAlert) {
            Button("Remove", role: .destructive) {
                viewModel.remove()
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("\(viewModel.name) will be removed from your wishlist.")
        }
    }
    
    private func sectionHeader(_ title: String, icon: String) -> some View {
        Label(title, systemImage: icon)
            .font(.headline)
            .foregroundStyle(.primary)
    }
    
    private var heroPlaceholder: some View {
        LinearGradient(
            colors: [.wanderAccent.opacity(0.4), .wanderAccent.opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(height: 280)
        .overlay {
            Image(systemName: "airplane.departure")
                .font(.system(size: 60))
                .foregroundStyle(.white.opacity(0.6))
        }
    }
}
