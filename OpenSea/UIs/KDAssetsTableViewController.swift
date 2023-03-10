//
//  KDAssetsTableViewController.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/17.
//

import Foundation
import UIKit
import SDWebImage
import MBProgressHUD


class KDAssetsTableViewController: UIViewController {

    init(viewModel: KDAssetsTableViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.numberOfAssets == 0 {
            Task {
                await viewModel.fetchAssets()
                await viewModel.fetchETHBalance()
            }
        }
    }

    // MARK: - Privates
    private var viewModel: KDAssetsTableViewControllerViewModel

    private lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.dataSource = self
        t.register(KDAssetCell.self, forCellReuseIdentifier: KDAssetCell.identifier)
        return t
    }()

    private let hud = MBProgressHUD()
}

extension KDAssetsTableViewController: KDAssetsTableViewControllerViewModelDelegate {

    func didFetchETHBalance(by viewModel: KDAssetsTableViewControllerViewModel, balance: Double) {
        DispatchQueue.main.async {
            self.title = "ETH Balance: \(balance)"
        }
    }

    func willFetchAssets(by viewModel: KDAssetsTableViewControllerViewModel) {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }


    func didAppendAssets(by viewModel: KDAssetsTableViewControllerViewModel) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }
    }

    func fetchAssetsFailed(by viewModel: KDAssetsTableViewControllerViewModel, error: KDError) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)

            let alert = UIAlertController(title: nil, message: error.reason, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }

    }

}

// MARK: - TableView
extension KDAssetsTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAssets
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KDAssetCell.identifier, for: indexPath) as? KDAssetCell ?? KDAssetCell()
        guard let asset = viewModel.asset(at: indexPath.row) else {
            return cell
        }
        cell.setup(thumbnameURLString: asset.thumbnailURLString ?? "", name: asset.name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == max(viewModel.numberOfAssets - 2, 0) {
            Task {
                await viewModel.fetchAssets()
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let asset = viewModel.asset(at: indexPath.row), let id = asset.id else {
            return
        }
        viewModel.goToAssetDetail(assetID: id)
    }

}
