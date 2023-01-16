//
//  KDAssetsList.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/16.
//

import Foundation

struct KDAssetsContainer: Decodable {
    let assets: [KDAsset]?
}

struct KDAsset: Decodable {
    let id: Int
    let imageURLString: String?
    let thumbnailURLString: String?
    let name: String?
    let permalink: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id, name, permalink, description
        case imageURLString = "image_url"
        case thumbnailURLString = "image_thumbnail_url"
    }
}

struct KDAssetCollection: Decodable {
    let name: String?
}
