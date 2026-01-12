//
//  ModeButton.swift
//  ColorMatchGame
//
//  Created by COBSCCOMP242P002 on 2026-01-12.
//

import SwiftUI

struct ModeButton: View {
    let title: String
    let stars: Int
    let color: Color
    let destination: AnyView?
    let disabled: Bool

    var body: some View {
        Group {
            if let destination = destination {
                NavigationLink {
                    destination
                } label: {
                    buttonContent
                }
            } else {
                Button(action: {}) {
                    buttonContent
                }
            }
        }
        .buttonStyle(GameModeButtonStyle(color: color))
        .disabled(disabled)
        .opacity(disabled ? 0.4 : 1)
    }

    private var buttonContent: some View {
        HStack(spacing: 2) {
            Text(title)
                .padding(.horizontal, 4)

            Spacer()

            HStack(spacing: 4) {
                ForEach(0..<stars, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

