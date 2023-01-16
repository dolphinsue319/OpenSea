//
//  KDAPIManager.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/16.
//

import Foundation


class KDAPIManager: KDAPIProtocol {

    func fetchAssets(at offset: UInt) async -> (KDAssetsContainer?, Error?) {
        let urlString = "https://testnets-api.opensea.io/api/v1/assets?owner=0x85fD692D2a075908079261F5E351e7fE0267dB02&offset=\(offset)&limit=20"
        guard let url = URL(string: urlString) else {
            return (nil, NSError())
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        do {
            let (data, response) = try await session.data(for: request)
        } catch {
            return(nil, NSError())
        }
        return (nil, NSError())
    }
}
