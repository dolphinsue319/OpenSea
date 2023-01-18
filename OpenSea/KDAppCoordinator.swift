//
//  KDAppCoordinator.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/17.
//

import Foundation
import UIKit

class KDAppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    func start() {
        goToAssetsPage()
    }
    func goToAssetsPage() {
        let vm = KDAssetsTableViewControllerViewModel(appCoordinator: self)
        let vc = KDAssetsTableViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToAssetDetailPage(collectionName: String?, imageURLString: String?, assetName: String?, description: String?, permalink: String?) {
        let vm = KDAssetDetailViewControllerViewModel(collectionName: collectionName, imageURLString: imageURLString, assetName: assetName, description: description, permalink: permalink)
        let vc = KDAssetDetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
