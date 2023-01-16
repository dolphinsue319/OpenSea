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
    let id: Int?
    let imageURLString: String?
    let thumbnailURLString: String?
    let name: String?
    let permalink: String?
    let description: String?
    var collectionName: String? {
        get {
            return collection?.name
        }
    }
    private let collection: KDAssetCollection?

    enum CodingKeys: String, CodingKey {
        case id, name, permalink, description, collection
        case imageURLString = "image_url"
        case thumbnailURLString = "image_thumbnail_url"
    }

    init(from decoder: Decoder) throws {
        let c = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? c?.decodeIfPresent(Int.self, forKey: .id)
        self.imageURLString = try? c?.decodeIfPresent(String.self, forKey: .imageURLString)
        self.thumbnailURLString = try? c?.decodeIfPresent(String.self, forKey: .thumbnailURLString)
        self.name = try? c?.decodeIfPresent(String.self, forKey: .name)
        self.permalink = try? c?.decodeIfPresent(String.self, forKey: .permalink)
        self.description = try? c?.decodeIfPresent(String.self, forKey: .description)
        self.collection = try? c?.decodeIfPresent(KDAssetCollection.self, forKey: .collection)
    }
}

struct KDAssetCollection: Decodable {
    let name: String?
}
