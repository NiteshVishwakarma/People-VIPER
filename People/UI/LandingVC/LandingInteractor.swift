//
//  LandingInteractor.swift
//  People
//
//  Created by Nitesh Vishwakarma on 13/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

class LandingInteractor: LandingInteractorInputProtocol {
    
    weak var presenter: LandingInteractorOutputProtocol?
    
    weak private var utils = Utils.shared()
    
    var httpClient: HTTPClientSerivce?
    
    func getUsers() {
        
        guard let url = URL(string: API.getUsers.url) else {
            return
        }
         let request = URLRequest(url: url)
        httpClient?.dataTask(urlRequest: request) { [weak self] (result) in
            switch result {
            case .success(let response):
                if let data = self?.utils?.toDictionary(data: response) {
                    self?.presenter?.getUsersSuccess(data: PeopleInfo(data: data).people)
                }
                break
            case .failure(let error):
                self?.presenter?.getUserFailed(error: error)
                break
            }
        }
    }
    
}
