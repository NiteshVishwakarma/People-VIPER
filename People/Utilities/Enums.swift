//
//  Enums.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

/// Consisit of API Errors.
enum Errors {
    
    case unknown
    case noNetwork
    
    var value: String {
        switch self {
        case .unknown:
            return "Something went wrong!"
        case .noNetwork:
            return "Please connect to internet"
        }
    }
    
}

/// Provide All api here
enum API {
    case getUsers
    
    var url: String {
        switch self {
        case .getUsers:
            return "https://jsonplaceholder.typicode.com/users"
        }
    }
    
}
