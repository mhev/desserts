//
//  Error.swift
//  fetchapp
//
//  Created by Michael Heverly on 6/11/24.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}
