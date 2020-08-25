//
//  Order.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable {
  case cappuccino
  case lattee
  case latte
  case espressino
  case cortado
}

enum CoffeeSize: String, Codable {
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
