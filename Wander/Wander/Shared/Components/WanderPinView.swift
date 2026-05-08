//
//  WanderPinView.swift
//  Wander
//
//  Created by Jessica Jesus on 30/03/2026.
//

import SwiftUI

struct WanderPinView: View {
    let item: WishlistItem
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color.wanderAccent.opacity(0.3))
                    .frame(width: 44, height: 44)
                    .scaleEffect(isAnimating ? 1.3 : 1.0)
                    .opacity(isAnimating ? 0 : 1)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                
                Circle()
                    .fill(Color.wanderAccent)
                    .frame(width: 36, height: 36)
                    .shadow(
                        color: .wanderAccent.opacity(0.4),
                        radius: 6,
                        x: 0,
                        y: 3
                    )
            }
            
            Triangle()
                .fill(Color.wanderAccent)
                .frame(width: 10, height: 6)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

