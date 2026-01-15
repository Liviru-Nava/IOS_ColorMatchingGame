//
//  SpaceTheme.swift
//  ColorMatchGame
//  Purpose is to store Global Styling to the game
//  Created by Liviru Navaratna on 2026-01-15.
//

import SwiftUI

struct SpaceTheme {
    
    //variable to store the Linear gradient background, accent, textColor
    static let background = LinearGradient(
        colors: [Color(red:0.08, green:0.05, blue:0.2),
                Color(red:0.02, green:0.02, blue:0.1)],
        startPoint: .top,
        endPoint: .bottom
    )
    static let accent = Color.cyan
    static let textColor = Color.white
}
