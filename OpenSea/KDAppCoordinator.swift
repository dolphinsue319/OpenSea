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
        
    }
}
