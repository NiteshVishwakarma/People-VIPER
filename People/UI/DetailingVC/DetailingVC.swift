//
//  DetailingVC.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class DetailingVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var likeImg: UIImageView!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var companyInfoLbl: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var companyBs: UILabel!
    
    @IBOutlet weak var companyPhrase: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var locateBtn: UIButton!
    
    //MARK: Variables
    
    var presenter: DetailingPresenterProtocol?
    
    /// Weak instance of userdefault(singleton).
//    
    
    //MARK: Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
    }
    
}

//MARK: Private Utility functions.
extension DetailingVC {
    
    /// Helps to configurate view controller.
    private func configure() {
        setupTheme()
        
        //LocateBtn
        locateBtn.addTarget(self, action: #selector(locate), for: .touchUpInside)
        
        //Like
        let likeGesture = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeImg.isUserInteractionEnabled = true
        likeImg.addGestureRecognizer(likeGesture)
    }
    
    /// Helps to set fonts and colors and view manipulation.
    private func setupTheme() {
        //FONT
        fonting()
        
        //InfoView
        infoView.backgroundColor = .black
        infoView.layer.cornerRadius = 30
        
        //LocateBtn
        locateBtn.setTitleColor(.white, for: .normal)
        locateBtn.titleLabel?.font = Font.set(type: .medium, size: 18)
        locateBtn.layer.borderWidth = 1
        locateBtn.layer.borderColor = UIColor.white.cgColor
        locateBtn.layer.cornerRadius = locateBtn.frame.height / 2
        locateBtn.setTitle("Locate", for: .normal)
        
        //White Labels
        Utils.shared().colorLabels(labels: [companyInfoLbl, companyName, companyBs, companyPhrase, addressLbl, address], color: .white)
        
        //Company & Address Sample text
        companyInfoLbl.text = "Company"
        addressLbl.text = "Address"
        
    }
    
    /// Font setter function.
    private func fonting() {
        //30 BOLD
        Font.set(labels: [name, companyInfoLbl, addressLbl], type: .bold, size: 30)
        
        //25 Bold
        Font.set(labels: [companyName], type: .medium, size: 25)
        
        //16 MEDIUM
        Font.set(labels: [companyBs, companyPhrase], type: .medium, size: 16)
        
        //20 Regular
        Font.set(labels: [phone, website, address], type: .regular, size: 20)
        
    }
    
    private func updateLike(status: Bool) {
        likeImg.image = status ? UIImage(named: "ic_favourite_filled") : UIImage(named: "ic_favourite_holo")
        presenter?.updateLike(status: status)
    }
    
}

//MARK: Targets
extension DetailingVC {
    
    /// Called when locate button is clicked.
    @objc private func locate() {
        presenter?.openMaps()
    }
    
    /// Called when like image is tapped.
    @objc private func likeTapped() {
        updateLike(status: !(presenter?.isLiked() ?? false))
    }
    
}

//MARK: Conforming to DetailingVCProtocol.
extension DetailingVC: DetailingVCProtocol {
    
    func setupUI() {
        guard let person = presenter?.person, let company = person.company, let address = person.address else {
            return
        }
        self.title = "@" + person.username
        self.name.text = person.name.replacingOccurrences(of: " ", with: "\n")
        self.phone.text = person.phone
        self.website.text = person.website
        
        //Company
        self.companyName.text = company.name
        self.companyBs.text = company.bs.capitalized
        self.companyPhrase.text = company.catchPhrase.capitalized
        
        //Address
        self.address.text = (address.street + ", " + address.suite + ", " + address.city + ", " + address.zipcode).capitalized
        
        //likeImg
        updateLike(status: presenter?.isLiked() ?? false)
    }
    
}
