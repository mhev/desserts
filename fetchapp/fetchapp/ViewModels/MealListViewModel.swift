//
//  MealListViewModel.swift
//  fetchapp
//
//  Created by Michael Heverly on 6/11/24.
//

import Combine
import Foundation

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var error: IdentifiableError? = nil
    
    private var mealService = MealService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchMeals()
    }
    
    func fetchMeals() {
        isLoading = true
        error = nil
        
        mealService.fetchDessertMeals { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let meals):
                    self?.meals = meals
                case .failure(let error):
                    self?.error = IdentifiableError(message: error.localizedDescription)  //error message
                }
            }
        }
    }
}

