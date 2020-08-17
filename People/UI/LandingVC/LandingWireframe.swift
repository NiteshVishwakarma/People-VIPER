//
//  LandingWireframe.swift
//  People
//
//  Created by Nitesh Vishwakarma on 13/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class LandingWireframe: LandingWireframeProtocol {
    
    /// Helps to create view controller
    public static func createModule() -> UIViewController {
        if let vc = UIStoryboard.init(name: "Landing", bundle: nil).instantiateViewController(withIdentifier: "LandingVC") as? LandingVC {
            let presenter: LandingPresenterProtocol & LandingInteractorOutputProtocol = LandingPresenter()
            let interactor: LandingInteractorInputProtocol = LandingInteractor()
            let wireframe: LandingWireframeProtocol = LandingWireframe()
            
            vc.presenter = presenter
            
            presenter.view = vc
            presenter.interactor = interactor
            presenter.wireframe = wireframe
            
            interactor.presenter = presenter
            interactor.httpClient = HTTPClient()
            
            return vc
        }
        return UIViewController()
    }
    
    func presentDetailingVC(view: LandingVCProtocol, data: Person) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(DetailingWireframe.createModule(people: data), animated: true)
        }
    }
    
}
