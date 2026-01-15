//
//  ModeButton.swift
//  ColorMatchGame
//  Reusable buttons for the mode selection
//  Created by COBSCCOMP242P002 on 2026-01-12.
//

import SwiftUI

struct ModeButton: View {
    let title: String
    let stars: Int
    let size: String

    var body: some View {
        
        //Vertical Stack Start
        VStack {
            Text(title)
                .font(.title2.bold())
                    
            Text(String(repeating: "⭐️", count: stars))
                    
            Text(size)
                .font(.caption)
        }
        .frame(width: 220, height: 80)
        .background(Color.blue.opacity(0.4))
        .foregroundColor(.white)
        .cornerRadius(15)
        .shadow(radius: 6)
        //Vertical Stack End
    }
}

