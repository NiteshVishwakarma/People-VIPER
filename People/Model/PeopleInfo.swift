//
//  PeopleInfo.swift
//  People
//
//  Created by Nitesh Vishwakarma on 14/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

class PeopleInfo {
    
    var people: [Person] = []
    
    init(data: [[String: Any]]) {
        for i in data {
            people.append(Person(data: i))
        }
    }
    
}

class Person {
    
    var phone: String = ""
    
    var website: String = ""
    
    var email: String = ""
    
    var name: String = ""
    
    var company: Company? = nil
    
    var id: Int = -1
    
    var address: Address? = nil
    
    var username: String = ""
    
    init(data: [String: Any]) {
        website = data["website"] as? String ?? ""
        phone = data["phone"] as? String ?? ""
        email = data["email"] as? String ?? ""
        name = data["name"] as? String ?? ""
        if let company = data["company"] as? [String : Any] {
            self.company = Company(data: company)
        }
        id = data["id"] as? Int ?? -1
        if let address = data["address"] as? [String : Any] {
            self.address = Address(data: address)
        }
        username = data["username"] as? String ?? ""
    }
    
}

class Company {
    
    var name: String = ""
    
    var catchPhrase: String = ""
    
    var bs: String = ""
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        catchPhrase = data["catchPhrase"] as? String ?? ""
        bs = data["bs"] as? String ?? ""
    }
    
}

class Address {
    
    var geo: Geo? = nil
    
    var street: String = ""
    
    var suite: String = ""
    
    var city: String = ""
    
    var zipcode: String = ""
    
    init(data: [String: Any]) {
        if let geo = data["geo"] as? [String : Any] {
            self.geo = Geo(data: geo)
        }
        street = data["street"] as? String ?? ""
        suite = data["suite"] as? String ?? ""
        city = data["city"] as? String ?? ""
        zipcode = data["zipcode"] as? String ?? ""
    }
    
}

class Geo {
    
    var lat: String = ""
    
    var lng: String = ""
    
    init(data: [String: Any]) {
        lat = data["lat"] as? String ?? ""
        lng = data["lng"] as? String ?? ""
    }
    
}
