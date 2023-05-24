//
//  MainViewController.swift
//  products
//
//  Created by Абдулла-Бек on 24/5/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var products: [Product] = []
    
    private lazy var productTableView: UITableView = {
        let view = UITableView()
        view.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let viewModel: MainViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = MainViewModel()
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        viewModel = MainViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        fetchData()
        setupSubViews()
    }
  
    private func fetchData() {
        Task {
            do {
                self.products = try await viewModel.fetchProducts()
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func setupSubViews() {
        view.addSubview(productTableView)
        
        productTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.bottom.equalToSuperview()
        }
    }

    func reloadProductTableView() {
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        products.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCell.reuseId,
            for: indexPath
        ) as! ProductCell
        cell.fill(product: products[indexPath.row])
        cell.delegate = self
        cell.productTapped = { [weak self] product in
            print("Product is: \(product)")
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: ProductCellDelegate {
    func fetchProduct(product: Product) {
        print("Product is: \(product)")
    }
}

