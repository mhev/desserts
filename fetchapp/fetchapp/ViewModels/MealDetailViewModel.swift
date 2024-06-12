//
//  ViewModel.swift
//  fetchapp
//
//  Created by Michael Heverly on 6/11/24.
//

import Combine
import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    @Published var error: IdentifiableError? = nil
    
    private var mealService = MealService()
    
    func fetchMealDetail(mealID: String) {
        isLoading = true
        error = nil
        
        mealService.fetchMealDetail(mealID: mealID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealDetail):
                    self?.mealDetail = mealDetail
                    print("Ingredients: \(mealDetail.ingredients)") //debugging for missing ingredients displaying
                case .failure(let error):
                    self?.error = IdentifiableError(message: error.localizedDescription)  //error message
                }
            }
        }
    }
}

