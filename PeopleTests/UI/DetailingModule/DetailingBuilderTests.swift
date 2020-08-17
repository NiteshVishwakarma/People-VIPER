//
//  DetailingBuilderTests.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import XCTest
import UIKit
@testable import People

class DetailingBuilderTests: XCTestCase {
    
    var vc: DetailingVC!
    
    var presenter: DetailingPresenter!
    
    var interactor: DetailingInteractor!
    
    var wireframe: DetailingWireframe!
    
    override func setUp() {
        vc = DetailingWireframe.createModule(people: getPerson()) as? DetailingVC
        presenter = vc.presenter as? DetailingPresenter
        interactor = presenter.interactor as? DetailingInteractor
        wireframe = presenter.wireframe as? DetailingWireframe
    }
    
    override func tearDown() {
        vc = nil
        presenter = nil
        interactor = nil
        wireframe = nil
    }
    
    func testDetailingModule() {
        XCTAssertTrue(vc != nil)
        XCTAssertTrue(presenter != nil)
        XCTAssertTrue(interactor != nil)
        XCTAssertTrue(wireframe != nil)
    }
    
    func testDetailingVC() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.presenter)
        XCTAssertTrue(vc.presenter is DetailingPresenter)
    }
    
    func testDetailingPresenter() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(presenter.wireframe)
        XCTAssertNotNil(presenter.person)
        XCTAssertTrue(presenter.view is DetailingVC)
        XCTAssertTrue(presenter.interactor is DetailingInteractor)
        XCTAssertTrue(presenter.wireframe is DetailingWireframe)
    }
    
    func testDetailingInteractor() {
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor.presenter)
        XCTAssertTrue(interactor.presenter is DetailingPresenter)
    }
    
    func testDetailingWireframe() {
        XCTAssertNotNil(wireframe)
    }
    
}

//MARK: Private utility functions
extension DetailingBuilderTests {
    
    /// Reads Users json file and plots data according to PeopleInfo.
    /// - Returns: PeopleInfo with data from Users.json
    func getPerson() -> Person {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Users", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        return PeopleInfo(data: Utils.shared().toDictionary(data: data)!).people[0]
    }
    
}
