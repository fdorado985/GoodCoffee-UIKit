//
//  Order.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
  case cappuccino
  case lattee
  case latte
  case espressino
  case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
  case small
  case medium
  case large
}

struct Order: Codable {

  let name: String
  let email: String
  let type: CoffeeType
  let size: CoffeeSize
}

extension Order {

  init?(_ viewModel: AddOrderViewModel) {
    guard let name = viewModel.name,
      let email = viewModel.email,
      let selectedType = viewModel.selectedType?.lowercased(),
      let selectedSize = viewModel.selectedSize?.lowercased(),
      let type = CoffeeType(rawValue: selectedType),
      let size = CoffeeSize(rawValue: selectedSize) else {
        return nil
    }

    self.name = name
    self.email = email
    self.type = type
    self.size = size
  }
}
