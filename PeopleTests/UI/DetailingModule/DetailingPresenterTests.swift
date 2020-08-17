//
//  DetailingPresenterTests.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import XCTest
@testable import People

class DetailingPresenterTests: XCTestCase {
    
    var interactor: DetailingInteractorMock!
    
    var presenter: DetailingPresenterMock!
    
    var view: DetailingVCMock!
    
    var wireframe: DetailingWireframeMock!
    
    override func setUp() {
        presenter = DetailingPresenterMock(person: getUserFromJson().people[0])
        interactor = DetailingInteractorMock()
        wireframe = DetailingWireframeMock()
        view = DetailingVCMock(presenter: presenter)
        
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
    
    func testDataLoaded() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.dataLoaded)
    }
    
    func testLikeTapped() {
        view.likeTap()
        XCTAssertTrue(view.likeTapped)
        XCTAssertTrue(presenter.likeUpdated)
    }
    
    func testMapsOpen() {
        view.mapTap()
        XCTAssertTrue(view.mapTapped)
        XCTAssertTrue(presenter.mapsOpen)
    }
    
}

class DetailingVCMock: UIViewController, DetailingVCProtocol {
    
    var presenter: DetailingPresenterProtocol?
    
    var dataLoaded = false
    
    var likeTapped = false
    
    var mapTapped = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DetailingPresenterMock) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    func setupUI() {
        dataLoaded = true
    }
    
    func likeTap() {
        likeTapped = true
        presenter?.updateLike(status: true)
    }
    
    func mapTap() {
        mapTapped = true
        presenter?.openMaps()
    }
    
}

class DetailingPresenterMock: DetailingPresenterProtocol, DetailingInteractorOutputProtocol {
    
    weak var view: DetailingVCProtocol?
    
    var interactor: DetailingInteractorInputProtocol?
    
    var wireframe: DetailingWireframeProtocol?
    
    var person: Person?
    
    var likeUpdated = false
    
    var mapsOpen = false
    
    init(person: Person) {
        self.person = person
    }
    
    func viewDidLoad() {
        view?.setupUI()
    }
    
    func openMaps() {
        mapsOpen = true
    }
    
    func updateLike(status: Bool) {
        likeUpdated = true
    }
    
    func isLiked() -> Bool {
        return false
    }
    
}

class DetailingInteractorMock: DetailingInteractorInputProtocol {
    
    var presenter: DetailingInteractorOutputProtocol?
    
}

class DetailingWireframeMock: DetailingWireframeProtocol {
    
}

extension DetailingPresenterTests {
    
    // Reads Users json file and plots data according to PeopleInfo.
    /// - Returns: PeopleInfo with data from Users.json
    func getUserFromJson() -> PeopleInfo {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Users", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        return PeopleInfo(data: Utils.shared().toDictionary(data: data)!)
    }
    
}
