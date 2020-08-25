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

  private let viewModel = OrdersViewModel()

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
    GCService().load(resource: resource) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let orders):
        self.viewModel.ordersViewModel = orders.map(OrderViewModel.init)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

// MARK: - TableView Delegate & DataSource

extension OrdersViewController {

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfOrders()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let orderVM = viewModel.orderViewModel(at: indexPath.row)
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
    cell.textLabel?.text = orderVM.type
    cell.detailTextLabel?.text = orderVM.size
    return cell
  }
}
