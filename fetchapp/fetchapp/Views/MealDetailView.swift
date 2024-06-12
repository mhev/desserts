//
//  MealDetailView.swift
//  fetchapp
//
//  Created by Michael Heverly on 6/11/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    let mealID: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let mealDetail = viewModel.mealDetail {
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                        .padding([.leading, .trailing, .top])
                    
                    if let urlString = mealDetail.strMealThumb, let url = URL(string: urlString) { //images of meal
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                        .padding([.top, .leading, .trailing])
                    
                    if let instructions = mealDetail.strInstructions {
                        Text(instructions)
                            .padding([.leading, .trailing, .bottom])
                    }
                    
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                        .padding([.top, .leading, .trailing])
                    
                    
                    ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                    }
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else if let errorMessage = viewModel.error?.message {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .onAppear {
            viewModel.fetchMealDetail(mealID: mealID) //once view appears trigger function for mealID
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

