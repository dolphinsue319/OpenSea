//
//  KDAssetDetailViewControllerViewModel.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/18.
//

import Foundation


class KDAssetDetailViewControllerViewModel {

    init(collectionName: String?, imageURLString: String?, assetName: String?, description: String?, permalink: String?) {
        self.collectionName = collectionName
        self.permalinkString = permalink
        self.imageURLString = imageURLString
        self.assetName = assetName
        self.description = description
    }

    private(set) var collectionName: String?
    private(set) var permalinkString: String?
    private(set) var imageURLString: String?
    private(set) var assetName: String?
    private(set) var description: String?
    private(set) var permalink: String?
}
