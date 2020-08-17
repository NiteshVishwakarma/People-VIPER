//
//  LandingPresenter.swift
//  People
//
//  Created by Nitesh Vishwakarma on 13/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation

class LandingPresenter: LandingPresenterProtocol {
    
    weak var view: LandingVCProtocol?
    
    var interactor: LandingInteractorInputProtocol?
    
    var wireframe: LandingWireframeProtocol?
    
    var people: [Person]?
    
    /// Weak Utils instance (singleton).
    weak private var utils = Utils.shared()
    
    func viewDidLoad() {
        getUser()
    }
    
    func viewWillAppear() {
        if let _ = people {
            view?.reloadTable()
        }
    }
    
    func showDetailing(index: Int) {
        if let data = people?[index] {
            wireframe?.presentDetailingVC(view: view!, data: data)
        }
    }
    
    func getUser() {
        if utils?.isConnectedToNetwork() ?? false {
            view?.startLoader()
            interactor?.getUsers()
        } else {
            view?.showError(message: Errors.noNetwork.value)
        }
    }
    
}

extension LandingPresenter: LandingInteractorOutputProtocol {
    
    func getUsersSuccess(data: [Person]) {
        view?.stopLoader()
        self.people = data
        view?.reloadTable()
    }
    
    func getUserFailed(error: String) {
        view?.stopLoader()
        view?.showError(message: error)
    }
    
}
