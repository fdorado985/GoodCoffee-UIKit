//
//  AddOrderViewController.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class AddOrderViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet var tableView: UITableView!

  // MARK: - Properties

  private var viewModel = AddOrderViewModel()
}

// MARK: - TableView Delegate & DataSource

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.types.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeCell", for: indexPath)
    cell.textLabel?.text = viewModel.types[indexPath.row]
    return cell
  }
}
