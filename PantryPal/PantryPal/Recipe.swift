//
//  Recipe.swift
//  PantryPal
//
//  Created by Praise Olatide on 8/3/25.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount: Int
    let missedIngredientCount: Int
}
