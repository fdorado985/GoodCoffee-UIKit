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
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!

  // MARK: - View Properties

  private var coffeeSizesSegmentedControl = UISegmentedControl()

  // MARK: - Properties

  private var viewModel = AddOrderViewModel()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureController()
  }

  // MARK: - Actions

  @IBAction func saveBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    let name = nameTextField.text
    let email = emailTextField.text

    let selectedSize = coffeeSizesSegmentedControl.titleForSegment(at: coffeeSizesSegmentedControl.selectedSegmentIndex)
    guard let selectedTypeIndexPath = self.tableView.indexPathForSelectedRow else {
      return
    }

    self.viewModel.name = name
    self.viewModel.email = email
    self.viewModel.selectedSize = selectedSize
    self.viewModel.selectedType = viewModel.types[selectedTypeIndexPath.row]
  }

  @IBAction func cancelBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
  }
}

// MARK: - Setup Views

extension AddOrderViewController {

  private func configureController() {
    setupLayouts()
  }

  private func setupLayouts() {
    configureCoffeeSizesSegmentedControl()
  }

  private func configureCoffeeSizesSegmentedControl() {
    coffeeSizesSegmentedControl = UISegmentedControl(items: viewModel.sizes)
    view.addSubview(coffeeSizesSegmentedControl)
    coffeeSizesSegmentedControl.selectedSegmentIndex = 0
    coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 24)
    ])
  }
}
