//
//  DetailingPresenter.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class DetailingPresenter: DetailingPresenterProtocol {
    
    weak var view: DetailingVCProtocol?
    
    var interactor: DetailingInteractorInputProtocol?
    
    var wireframe: DetailingWireframeProtocol?
    
    var person: Person?
    
    private weak var defaults = UserDefaults.standard
    
    func viewDidLoad() {
        view?.setupUI()
    }
    
    func openMaps() {
        guard let geo = person?.address?.geo, let url = URL(string: Constants.mapsURL + geo.lat + "," + geo.lng) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func updateLike(status: Bool) {
        guard let id = person?.id else {
            return
        }
        defaults?.set(status, forKey: "\(id)")
    }
    
    func isLiked() -> Bool {
        guard let id = person?.id else {
            return false
        }
        return defaults?.bool(forKey: "\(id)") ?? false
    }
    
}

extension DetailingPresenter: DetailingInteractorOutputProtocol {
    
}
