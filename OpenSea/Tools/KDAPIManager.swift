//
//  KDAPIManager.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/16.
//

import Foundation

class KDAPIManager {

    func fetchAssets(at offset: UInt) async -> (KDAssetsContainer?, KDError?) {
        let urlString = "https://testnets-api.opensea.io/api/v1/assets?owner=\(ownerAddress)&offset=\(offset)&limit=20"
        guard let url = URL(string: urlString) else {
            return (nil, .URLStringError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        do {
            let (data, _) = try await session.data(for: request)
            let container = try JSONDecoder().decode(KDAssetsContainer.self, from: data)
            return (container, nil)
        } catch {
            return(nil, .JSONDecodeError)
        }
    }

    func fetchETHBalance() async -> (Double?, KDError?) {
        let urlString = "https://mainnet.infura.io/v3/1a951805f324441b8898db0cf554bd1b"
        guard let url = URL(string: urlString) else {
            return (nil, .URLStringError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let bodyObject: [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "eth_getBalance",
            "params": [
                ownerAddress,
                "latest"
            ]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyObject, options: [])
        let session = URLSession(configuration: .default)
        do {
            let (data, _) = try await session.data(for: request)
            let container = try JSONDecoder().decode(KDETHBalanceContainerModel.self, from: data)
            if let doubleValue = container.resultDouble {
                return(doubleValue, nil)
            }
            return (nil, .JSONDecodeError)
        } catch {
            return(nil, .JSONDecodeError)
        }
    }

    private let ownerAddress = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
}
