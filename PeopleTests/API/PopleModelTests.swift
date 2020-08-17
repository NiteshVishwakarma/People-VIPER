//
//  PopleModelTests.swift
//  PeopleTests
//
//  Created by Nitesh Vishwakarma on 16/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import XCTest
@testable import People

class PeopleModelTests: XCTestCase {
    
    var info: PeopleInfo!
    var person: Person!
    var utils: Utils!
    
    override func setUp() {
        info = PeopleInfo(data: [])
        person = Person(data: [:])
        utils = Utils.shared()
    }
    
    override func tearDown() {
        info = nil
        person = nil
        utils = nil
    }
    
    /// Checks whether setup is complete.
    func testIsEmpty() {
        XCTAssertTrue(info.people.isEmpty)
        XCTAssertFalse(person == nil)
    }
    
    func testIsMappable() {
        
    }
    
    /// Check whether data is mapped properly. This function only tests first object.
    func testMapping() {
        setUsers()
        
        person = info.people[0]
        XCTAssertFalse(person == nil)
        
        XCTAssertEqual(person.id, 1)
        XCTAssertEqual(person.name, "Leanne Graham")
        XCTAssertEqual(person.username, "Bret")
        XCTAssertEqual(person.email, "Sincere@april.biz")
        XCTAssertEqual(person.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(person.website, "hildegard.org")
        
        let address = person.address
        XCTAssertFalse(address == nil)

        XCTAssertEqual(address!.street, "Kulas Light")
        XCTAssertEqual(address!.suite, "Apt. 556")
        XCTAssertEqual(address!.city, "Gwenborough")
        XCTAssertEqual(address!.zipcode, "92998-3874")
        
        let geo = address!.geo
        XCTAssertFalse(geo == nil)
        
        XCTAssertEqual(geo!.lat, "-37.3159")
        XCTAssertEqual(geo!.lng, "81.1496")

        let company = person.company
        XCTAssertFalse(company == nil)
        
        XCTAssertEqual(company!.name, "Romaguera-Crona")
        XCTAssertEqual(company!.catchPhrase, "Multi-layered client-server neural-net")
        XCTAssertEqual(company!.bs, "harness real-time e-markets")
    }
    
    func testIsInfoNotEmptyAndCount() {
        setUsers()
        XCTAssertFalse(info.people.isEmpty)
        XCTAssertEqual(info.people.count, 3)
    }
    
}

//MARK: Private utility functions
extension PeopleModelTests {
    
    /// Helps to map data from Users.json file.
    private func setUsers() {
        info = getUserFromJson()
    }
    
    /// Reads Users json file and plots data according to PeopleInfo.
    /// - Returns: PeopleInfo with data from Users.json
    func getUserFromJson() -> PeopleInfo {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Users", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        return PeopleInfo(data: Utils.shared().toDictionary(data: data)!)
    }
    
}
