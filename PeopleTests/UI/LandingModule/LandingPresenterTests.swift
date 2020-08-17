//
//  LandingPresenterTests.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import XCTest
import UIKit
@testable import People

class LandingPresenterTests: XCTestCase {
    
    var interactor: LandingInteractorMock!
    
    var presenter: LandingPresenterMock!
    
    var view: LandingVCMock!
    
    var wireframe: LandingWireframeMock!
    
    override func setUp() {
        presenter = LandingPresenterMock()
        let client = MockHTTPClient()
        interactor = LandingInteractorMock(presenter: presenter, httpClient: client)
        wireframe = LandingWireframeMock()
        view = LandingVCMock(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.wireframe = wireframe
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        interactor = nil
        wireframe = nil
    }
    
    func testShowUsers() {
        presenter.viewDidLoad()
        wait(for: 2)
        XCTAssertTrue(presenter.usersDataSucess)
        XCTAssertTrue(view.tableReloaded)
    }
    
    func testShowDetailing() {
        presenter.viewDidLoad()
        wait(for: 2)
        presenter.showDetailing(index: 0)
        XCTAssertTrue(presenter.personSelected)
        XCTAssertTrue(wireframe.presentDetalingSuccess)
    }
    
}

class LandingVCMock: UIViewController, LandingVCProtocol {
    
    var presenter: LandingPresenterProtocol?
    
    var tableReloaded = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: LandingPresenterMock) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    func reloadTable() {
        tableReloaded = true
    }
    
    func showError(message: String) {
        tableReloaded = false
    }
    
    func startLoader() {}
    
    func stopLoader() {}
    
}

class LandingWireframeMock: LandingWireframeProtocol {
    
    var presentDetalingSuccess: Bool = false
    
    func presentDetailingVC(view: LandingVCProtocol, data: Person) {
        presentDetalingSuccess = true
    }
    
}

class LandingPresenterMock: LandingPresenterProtocol, LandingInteractorOutputProtocol {
    
    weak var view: LandingVCProtocol?
    
    var interactor: LandingInteractorInputProtocol?
    
    var wireframe: LandingWireframeProtocol?
    
    var usersDataSucess: Bool = false
    
    var people: [Person]?
    
    var personSelected = false
    
    func viewDidLoad() {
        getUser()
    }
    
    func viewWillAppear() {}
    
    func showDetailing(index: Int) {
        wireframe?.presentDetailingVC(view: view!, data: people![index])
        personSelected = true
    }
    
    func getUser() {
        interactor?.getUsers()
    }
    
    func getUsersSuccess(data: [Person]) {
        usersDataSucess = true
        self.people = data
        view?.reloadTable()
    }
    
    func getUserFailed(error: String) {
        usersDataSucess = false
        view?.showError(message: error)
    }
    
}
