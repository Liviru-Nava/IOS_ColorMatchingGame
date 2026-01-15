//
//  GridOption.swift
//  ColorMatchGame
//
//  Created by Liviru Navaratna on 2026-01-15.
//

import Foundation

struct GridOption: Identifiable {
    let id = UUID()
    let rows: Int
    let columns: Int
    let label: String
}
