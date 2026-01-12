//
//  GameModeButtonStyle.swift
//  ColorMatchGame
//
//  Created by COBSCCOMP242P002 on 2026-01-12.
//
import SwiftUI

struct GameModeButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .frame(width: 220, height: 55)
            .background(color.opacity(configuration.isPressed ? 0.6 : 1))
            .foregroundColor(.white)
            .cornerRadius(14)
            .shadow(radius: 5)
    }
}
