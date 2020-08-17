//
//  APIRequest.swift
//  People
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

public enum Result<Value, E> {
    case success(Value)
    case failure(E)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }

}

protocol HTTPClientSerivce {
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, String>) -> Void))
}

class HTTPClient: HTTPClientSerivce {
    
    
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, String>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                guard let msg = error?.localizedDescription, !msg.isEmpty else {
                    completion(Result.failure(Errors.unknown.value))
                    return
                }
                completion(Result.failure(msg))
                return
            }
            guard let _response = response as? HTTPURLResponse, _response.statusCode == 200, let _data = data as Data? else {
                completion(Result.failure(Errors.unknown.value))
                return
            }
            completion(Result.success(_data))
        }
        task.resume()
    }
    
}


