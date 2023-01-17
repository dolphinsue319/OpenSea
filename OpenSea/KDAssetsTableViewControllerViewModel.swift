//
//  KDAssetsTableViewControllerViewModel.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/17.
//

import Foundation

protocol KDAssetsTableViewControllerViewModelDelegate: AnyObject {
    func didAppendAssets(by viewModel: KDAssetsTableViewControllerViewModel)
    func fetchAssetsFailed(by viewModel: KDAssetsTableViewControllerViewModel)
}

class KDAssetsTableViewControllerViewModel {

    weak var delegate: KDAssetsTableViewControllerViewModelDelegate?

    init(appCoordinator: KDAppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func fetchAssets() async {
        if isFetching {
            return
        }
        isFetching = true
        let (container, error) = await KDAPIManager().fetchAssets(at: pageIndex)
        isFetching = false
        guard error == nil, let container = container else {
            delegate?.fetchAssetsFailed(by: self)
            return
        }
        pageIndex += 1
        self.assets = container.assets
        delegate?.didAppendAssets(by: self)
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

    // MARK: - Privates6
    private var appCoordinator: KDAppCoordinator
    private var pageIndex: UInt = 0
    private var assets: [KDAsset]?
    private var isFetching: Bool = false
}
