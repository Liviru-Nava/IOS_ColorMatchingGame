//
//  GameColor.swift
//  ColorMatchGame
//
//  Created by Liviru Navaratna on 2026-01-03.
//

import SwiftUI

enum GameColor: CaseIterable {
    case red
    case blue
    case yellow
}

extension GameColor {
    var uiColor: Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        }
    }
}
