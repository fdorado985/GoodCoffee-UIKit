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

  // MARK: - Properties

  let name: String
  let email: String
  let type: CoffeeType
  let size: CoffeeSize

  // MARK: Computed Properties

  static var all: Resource<[Order]> = {
    guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
      fatalError("URL is incorrect")
    }

    return Resource<[Order]>(url: url)
  }()

  // MARK: - Initializer

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

  // MARK: - Methods

  static func create(viewModel: AddOrderViewModel) -> Resource<Order?> {
    let order = Order(viewModel)
    guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
      fatalError("URL is incorrect")
    }

    guard let data = try? JSONEncoder().encode(order) else {
      fatalError("Error encoding order!")
    }

    var resource = Resource<Order?>(url: url)
    resource.method = .post
    resource.body = data

    return resource
  }
}
