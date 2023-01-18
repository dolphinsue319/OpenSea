//
//  KDError.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/16.
//

import Foundation

enum KDError: Error {
    case URLStringError
    case JSONDecodeError

    var reason: String {
        switch self {
        case .JSONDecodeError:
            return "JSON string parsing error"
        case .URLStringError:
            return "URL string is wrong format"
        }
    }
}
