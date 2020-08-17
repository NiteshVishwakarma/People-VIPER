//
//  DetailingWireframe.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class DetailingWireframe: DetailingWireframeProtocol {
    
    /// Helps to create view controller
    public static func createModule(people: Person) -> UIViewController {
        if let vc = UIStoryboard.init(name: "Detailing", bundle: nil).instantiateViewController(withIdentifier: "DetailingVC") as? DetailingVC {
            let presenter: DetailingPresenterProtocol & DetailingInteractorOutputProtocol = DetailingPresenter()
            let interactor: DetailingInteractorInputProtocol = DetailingInteractor()
            let wireframe: DetailingWireframeProtocol = DetailingWireframe()
            
            vc.presenter = presenter
            
            presenter.view = vc
            presenter.interactor = interactor
            presenter.wireframe = wireframe
            presenter.person = people
            
            interactor.presenter = presenter
            
            return vc
        }
        return UIViewController()
    }

}
