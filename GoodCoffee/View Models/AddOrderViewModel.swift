//
//  AddOrderViewModel.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

struct AddOrderViewModel {

  var name: String?
  var email: String?
  var selectedType: String?
  var selectedSize: String?

  var types: [String] {
    return CoffeeType.allCases.map { $0.rawValue.capitalized }
  }

  var sizes: [String] {
    return CoffeeSize.allCases.map { $0.rawValue.capitalized }
  }
}
