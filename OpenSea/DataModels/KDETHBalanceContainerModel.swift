//
//  KDETHBalanceContainerModel.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/18.
//

import Foundation

struct KDETHBalanceContainerModel: Decodable {
    let jsonrpc: String?
    let id: Int?
    let result: String?
    var resultDouble: Double? {
        get {
            guard let r = result else {
                return nil
            }
            let scanner = Scanner(string: r)
            var decimal: Double = 0
            if scanner.scanHexDouble(&decimal) {
                return decimal
            }
            return nil
        }
    }
}
