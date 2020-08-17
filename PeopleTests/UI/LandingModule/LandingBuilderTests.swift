//
//  LandingUITests.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import XCTest
import UIKit
@testable import People

class LandingBuilderTests: XCTestCase {
    
    var vc: LandingVC!
    var presenter: LandingPresenter!
    var interactor: LandingInteractor!
    var wireframe: LandingWireframe!
    
    override func setUp() {
        vc = LandingWireframe.createModule() as? LandingVC
        presenter = vc.presenter as? LandingPresenter
        interactor = presenter.interactor as? LandingInteractor
        wireframe = presenter.wireframe as? LandingWireframe
    }
    
    override func tearDown() {
        vc = nil
        presenter = nil
        interactor = nil
        wireframe = nil
    }
    
    func testLandingModule() {
        XCTAssertTrue(vc != nil)
        XCTAssertTrue(presenter != nil)
        XCTAssertTrue(interactor != nil)
        XCTAssertTrue(wireframe != nil)
    }
    
    func testLandingVC() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.presenter)
        XCTAssertTrue(vc.presenter is LandingPresenter)
    }
    
    func testLandingPresenter() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(presenter.wireframe)
        XCTAssertTrue(presenter.view is LandingVC)
        XCTAssertTrue(presenter.interactor is LandingInteractor)
        XCTAssertTrue(presenter.wireframe is LandingWireframe)
    }
    
    func testLandingInteractor() {
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor.presenter)
        XCTAssertTrue(interactor.presenter is LandingPresenter)
    }
    
    func testLandingWireframe() {
        XCTAssertNotNil(wireframe)
    }
    
}
