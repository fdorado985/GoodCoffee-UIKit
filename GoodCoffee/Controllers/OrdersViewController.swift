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
    GCService().load(resource: Order.all) { [weak self] result in
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

  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "\(AddOrderViewController.self)",
      let addOrderVC = segue.destination as? AddOrderViewController {
      addOrderVC.delegate = self
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

extension OrdersViewController: AddOrderDelegate {

  func addOrderViewController(_ viewController: AddOrderViewController, didSaveOrder order: Order) {
    viewController.navigationController?.popViewController(animated: true)
    let orderVM = OrderViewModel(order)
    viewModel.ordersViewModel.append(orderVM)
    tableView.insertRows(at: [IndexPath(row: viewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
  }

  func addOrderViewControllerDidClose(_ viewController: AddOrderViewController) {
    viewController.navigationController?.popViewController(animated: true)
  }
}
