//
//  KDAssetsTableViewController.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/17.
//

import Foundation
import UIKit


class KDAssetsTableViewController: UIViewController {

    var viewModel: KDAssetsTableViewControllerViewModel

    init(viewModel: KDAssetsTableViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
