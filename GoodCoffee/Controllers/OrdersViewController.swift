//
//  OrdersViewController.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class OrdersViewController: UITableViewController {

  // MARK: - Properties

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    fetchOrders()
  }

  // MARK: - Methods

  private func fetchOrders() {
    guard let coffeeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
      fatalError("URL was incorrect")
    }

    let resource = Resource<[Order]>(url: coffeeOrdersURL)
    GCService().load(resource: resource) { result in
      switch result {
      case .success(let orders):
        print(orders)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
