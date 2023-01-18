//
//  ArrayExtension.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/18.
//

import Foundation


extension Array where Element == KDAsset {

    mutating func appendIfNotExist(newAssets: [KDAsset]) {
        for newA in newAssets {
            if !self.contains(where: { a in
                a.id == newA.id
            }) {
                self.append(newA)
            }
        }
    }
}
