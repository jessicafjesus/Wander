//
//  WanderMapView.swift
//  Wander
//
//  Created by Jessica Jesus on 30/03/2026.
//


import SwiftUI
import MapboxMaps

struct WanderMapView: View {
    @StateObject var viewModel: WanderMapViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(viewport: $viewModel.viewport) {
                ForEvery(viewModel.items) { item in
                    MapViewAnnotation(coordinate: item.coordinate) {
                        WanderPinView(item: item)
                            .onTapGesture {
                                viewModel.selectItem(item)
                                viewModel.flyTo(item)
                            }
                    }
                }
            }
            .mapStyle(.standard)
            .ignoresSafeArea()
            
            if viewModel.isEmpty {
                emptyStateOverlay
                    .padding(.bottom, 32)
            }
        }
        .sheet(item: $viewModel.selectedItem) { item in
            PlaceDetailView(
                viewModel: PlaceDetailViewModel(
                    item: item,
                    wishlistStore: viewModel.wishlistStore
                )
            )
        }
    }
    
    private var emptyStateOverlay: some View {
        VStack(spacing: 8) {
            Image(systemName: "map")
                .font(.title2)
            Text("Start adding places\nto see them here")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.secondary)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}
