//
//  Meal.swift
//  fetchapp
//
//  Created by Michael Heverly on 6/11/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
    
    var id: String { idMeal } //identifiable
}
