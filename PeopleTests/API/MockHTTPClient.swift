//
//  MockAPIRequest.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
@testable import People

class MockHTTPClient: HTTPClientSerivce {
    
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, String>) -> Void)) {
        switch urlRequest.url?.absoluteString {
        case API.getUsers.url:
            let bundle = Bundle(for: type(of: self))
            let fileUrl = bundle.url(forResource: "Users", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            completion(Result.success(data))
            break
        default:
            completion(Result.failure(""))
            break   
        }
    }
    
    
}
