//
//  Services.swift
//  fetchapp
//
//  Created by Michael Heverly on 6/11/24.
//

import Foundation

class MealService {
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    func fetchDessertMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let urlString = "\(baseURL)filter.php?c=Dessert" //specify dessert from api
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 2, userInfo: nil)))
                return
            }
            
            do {
                let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                let sortedMeals = mealResponse.meals.sorted(by: { $0.strMeal < $1.strMeal }) //alphabetical order
                completion(.success(sortedMeals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMealDetail(mealID: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        let urlString = "\(baseURL)lookup.php?i=\(mealID)" //meal ID to fetch each meal
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 2, userInfo: nil)))
                return
            }
            
            do {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response: \(jsonString)")
                }
                
                let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let mealDetail = mealDetailResponse.meals.first {
                    completion(.success(mealDetail))
                } else {
                    completion(.failure(NSError(domain: "No Detail Found", code: 3, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


//parsing json
struct MealResponse: Codable {
    let meals: [Meal]
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
