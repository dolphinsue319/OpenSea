//
//  KDAssetsTableViewControllerViewModel.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/17.
//

import Foundation

protocol KDAssetsTableViewControllerViewModelDelegate: AnyObject {
    func willFetchAssets(by viewModel: KDAssetsTableViewControllerViewModel)
    func didAppendAssets(by viewModel: KDAssetsTableViewControllerViewModel)
    func fetchAssetsFailed(by viewModel: KDAssetsTableViewControllerViewModel, error: KDError)

    func didFetchETHBalance(by viewModel: KDAssetsTableViewControllerViewModel, balance: Double)
}

class KDAssetsTableViewControllerViewModel {

    weak var delegate: KDAssetsTableViewControllerViewModelDelegate?

    init(appCoordinator: KDAppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func fetchETHBalance() async {
        let (balance, _) = await KDAPIManager().fetchETHBalance()
        if let balance = balance {
            delegate?.didFetchETHBalance(by: self, balance: balance)
        }
    }

    func fetchAssets() async {
        if isFetching {
            return
        }
        isFetching = true
        delegate?.willFetchAssets(by: self)
        let (container, error) = await KDAPIManager().fetchAssets(at: pageIndex)
        guard error == nil, let container = container, let inAssets = container.assets else {
            delegate?.fetchAssetsFailed(by: self, error: error!)
            isFetching = false
            return
        }
        if inAssets.count == 0 {
            isFetching = true
            self.delegate?.didAppendAssets(by: self)
            return
        }
        if self.assets == nil {
            self.assets = [KDAsset]()
        }
        self.assets?.appendIfNotExist(newAssets: inAssets)
        self.delegate?.didAppendAssets(by: self)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.pageIndex += UInt(inAssets.count)
            self?.isFetching = false
        }
    }

    var numberOfAssets: Int {
        get {
            return (assets?.count) ?? 0
        }
    }

    func asset(at index: Int) -> KDAsset? {
        if (index >= (assets?.count ?? -1)) {
            return nil
        }
        return assets?[index]
    }

    func goToAssetDetail(assetID id: Int) {
        guard let asset = assets?.first(where: { a in
            return a.id == id
        }) else {
            return
        }
        appCoordinator.goToAssetDetailPage(collectionName: asset.collectionName, imageURLString: asset.imageURLString, assetName: asset.name, description: asset.description, permalink: asset.permalink)
    }

    // MARK: - Privates
    private var appCoordinator: KDAppCoordinator
    private var pageIndex: UInt = 0
    private var assets: [KDAsset]?
    private let locker = NSLock()
    private var _isFetching: Bool = false
    private var isFetching: Bool {
        get {
            return _isFetching
        }
        set {
            locker.lock()
            _isFetching = newValue
            locker.unlock()
        }
    }
}
