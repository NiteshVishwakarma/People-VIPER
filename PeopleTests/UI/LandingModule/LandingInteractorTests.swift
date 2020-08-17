//
//  LandingInteractorTests.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import XCTest
@testable import People

class LandingInteractorTests: XCTestCase {
    
    var interactor: LandingInteractorMock!
    
    var presenter: LandingInteractorOutputMock!
    
    var client: HTTPClientSerivce!
    
    override func setUp() {
        presenter = LandingInteractorOutputMock()
        client = MockHTTPClient()
        interactor = LandingInteractorMock(presenter: presenter, httpClient: client)
    }
    
    override func tearDown() {
        interactor = nil
        presenter = nil
        client = nil
    }
    
    func testGetUsersAPI() {
        interactor.getUsers()
        wait(for: 2)
        XCTAssertTrue(presenter.success)
        XCTAssertTrue(interactor.requestCalled)
    }
    
    func testGetUserAPIError() {
        interactor.url = "invalidurl"
        interactor.getUsers()
        wait(for: 2)
        XCTAssertFalse(presenter.success)
        XCTAssertTrue(interactor.requestCalled)
    }

}

class LandingInteractorOutputMock: LandingInteractorOutputProtocol {
    
    var success = false
    
    func getUsersSuccess(data: [Person]) {
        success = true
        XCTAssertFalse(data.isEmpty)
    }
    
    func getUserFailed(error: String) {
        success = false
    }
    
}

class LandingInteractorMock: LandingInteractorInputProtocol {
    
    weak var presenter: LandingInteractorOutputProtocol?
    
    var httpClient: HTTPClientSerivce?
    
    var requestCalled: Bool = false
    
    var url = API.getUsers.url
    
    init(presenter: LandingInteractorOutputProtocol, httpClient: HTTPClientSerivce) {
        self.presenter = presenter
        self.httpClient = httpClient
    }
    
    func getUsers() {
        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        httpClient?.dataTask(urlRequest: request) { (result) in
            switch result {
            case .success(let response):
                self.requestCalled = true
                let data = Utils.shared().toDictionary(data: response)
                self.presenter?.getUsersSuccess(data: PeopleInfo(data: data!).people)
                break
            case .failure(let error):
                self.requestCalled = true
                self.presenter?.getUserFailed(error: error)
                break
            }
        }
    }
    
}

extension XCTestCase {
    
    /// Helps to run url after few seconds.
    /// - Parameter duration: Provide duration for wait time.
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }
    
}
