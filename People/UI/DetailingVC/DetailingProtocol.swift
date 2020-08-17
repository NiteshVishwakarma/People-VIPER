//
//  DetailingProtocol.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

protocol DetailingVCProtocol: class {
    
    /// Helps to maintain presenter's protocol instance at view controller.
    var presenter: DetailingPresenterProtocol? { get set }
    
    /// Helps to populate data.
    func setupUI()
    
}

protocol DetailingPresenterProtocol: class {
    
    /// Helps to maintain view controller's protocol instance at presenter.
    var view: DetailingVCProtocol? { get set }
    
    /// Helps to maintain Input Interactor's protocol instance at presenter.
    var interactor: DetailingInteractorInputProtocol? { get set }
    
    /// Helps to maintain Wireframe's protocol instance at presenter.
    var wireframe: DetailingWireframeProtocol? { get set }
    
    /// Maintain People information retrieved by LandingVC.
    var person: Person? { get set }
    
    /// Let presenter performs viewDidLoad.
    func viewDidLoad()
    
    /// Helps to view maps cordinates.
    func openMaps()
    
    /// Helps to update like status of the person in user defaults.
    /// - Parameter status: Provide true or false.
    func updateLike(status: Bool)
    
    /// Helps to get status of the person, whether liked or not.
    func isLiked() -> Bool
    
}

protocol DetailingInteractorInputProtocol: class {
    
    /// Helps to maintain Output Interactor's protocol instance at Interactor input.
    var presenter: DetailingInteractorOutputProtocol? { get set }
    
}

protocol DetailingInteractorOutputProtocol: class {}

protocol DetailingWireframeProtocol: class {}
