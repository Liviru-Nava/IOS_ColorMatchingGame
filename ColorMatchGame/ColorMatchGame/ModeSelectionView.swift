//
//  ModeSelectionView.swift
//  ColorMatchGame
//  This will be the splash screen to select the mode for the game
//  Created by COBSCCOMP242P002 on 2026-01-12.
//

import SwiftUI

struct ModeSelectionView: View {
    var body: some View {
        ZStack {
            // 🌌 Dark background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.08, green: 0.10, blue: 0.18), // deep navy
                    Color(red: 0.15, green: 0.10, blue: 0.30), // dark purple
                    Color(red: 0.10, green: 0.05, blue: 0.20)  // midnight violet
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // 🎮 Content
            VStack(spacing: 30) {
                Text("Welcome to Color Match Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                ModeButton(
                    title: "Easy Mode",
                    stars: 1,
                    color: .green,
                    destination: AnyView(EasyGameView()),
                    disabled: false
                )

                ModeButton(
                    title: "Medium Mode",
                    stars: 2,
                    color: .orange,
                    destination: nil,
                    disabled: true
                )

                ModeButton(
                    title: "Hard Mode",
                    stars: 3,
                    color: .red,
                    destination: nil,
                    disabled: true
                )
            }
            .padding()
        }
    }
}

