//
//  LandingProtocol.swift
//  People
//
//  Created by Nitesh Vishwakarma on 13/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

protocol LandingVCProtocol: class {
    
    /// Helps to maintain presenter's protocol instance at view controller.
    var presenter: LandingPresenterProtocol? { get set }
    
    /// Helps to reload table view.
    func reloadTable()
    
    /// Helps to alert error.
    /// - Parameter message: Provide error message.
    func showError(message: String)
    
    /// Helps to start Activity Loader.
    func startLoader()
    
    /// Helps to stop Activity Loader.
    func stopLoader()
    
}

protocol LandingPresenterProtocol: class {
    
    /// Helps to maintain view controller's protocol instance at presenter.
    var view: LandingVCProtocol? { get set }
    
    /// Helps to maintain Input Interactor's protocol instance at presenter.
    var interactor: LandingInteractorInputProtocol? { get set }
    
    /// Helps to maintain Wireframe's protocol instance at presenter.
    var wireframe: LandingWireframeProtocol? { get set }
    
    /// Maintain Peoples information retrieved by getUsers API.
    var people: [Person]? { get set }
    
    /// Let presenter performs viewDidLoad.
    func viewDidLoad()
    
    /// Let presenter performs viewWillAppear.
    func viewWillAppear()
    
    /// Helps to present DetailingVC.
    /// - Parameter index: Pass the index of user whose data needs to be populated.
    func showDetailing(index: Int)
    
    /// Helps to call getUsers API.
    func getUser()
    
}

protocol LandingInteractorInputProtocol: class {
    
    /// Helps to maintain Output Interactor's protocol instance at Interactor input.
    var presenter: LandingInteractorOutputProtocol? { get set }
    
    /// Helps to hit API's.
    var httpClient: HTTPClientSerivce? { get set }
    
    /// Api to get all users.
    func getUsers()
    
}

protocol LandingInteractorOutputProtocol: class {
    
    /// Receives callback when api data is formed and successfully parsed.
    /// - Parameter data: Returns object of PeopleInfo
    func getUsersSuccess(data: [Person])
    
    /// Recieves callback when api
    /// - Parameter error: 
    func getUserFailed(error: String)
    
}

protocol LandingWireframeProtocol: class {
    
    /// Helps to push DetailingVC.
    /// - Parameters:
    ///   - view: Provide LandingVCProtocol as view from presenter so as to get LandingVC.
    ///   - data: Pass user specific data to populate the DetailingVC.
    func presentDetailingVC(view: LandingVCProtocol, data: Person)
    
}

