//
//  OrderViewModel.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

class OrdersViewModel {

  var ordersViewModel: [OrderViewModel]

  init() {
    self.ordersViewModel = [OrderViewModel]()
  }
}

extension OrdersViewModel {

  func orderViewModel(at index: Int) -> OrderViewModel {
    return ordersViewModel[index]
  }
}

struct OrderViewModel {

  private let order: Order

  var name: String {
    return order.name
  }

  var email: String {
    return order.email
  }

  var type: String {
    return order.type.rawValue.capitalized
  }

  var size: String {
    return order.size.rawValue.capitalized
  }
}

extension OrderViewModel {

  init(_ order: Order) {
    self.order = order
  }
}
