//
//  SquareView.swift
//  ColorMatchGame
//
//  Created by Liviru Navaratna on 2025-12-21.
//

import SwiftUI

struct SquareView: View {
    
    let color: GameColor
    let onTap: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(color.uiColor)
            .frame(width: 100, height: 100)
            .onTapGesture {
                onTap()
            }
    }
}

#Preview {
    SquareView(color: .blue, onTap: {})
}
