//
//  KDAPIProtocol.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/16.
//

import Foundation

protocol KDAPIProtocol {
    func fetchAssets(at offset: UInt) async -> (KDAssetsContainer?, KDError?)
}
