//
//  CoordinatorProtocol.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/17.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }

    func start()
}
