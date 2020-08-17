//
//  LandingVCTableViewCell.swift
//  People
//
//  Created by Nitesh Vishwakarma on 14/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import UIKit

class LandingVCTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var like: UIImageView!
    
    //MARK: Variables
    
    private weak var defaults = UserDefaults.standard
    
    //MARK: Lifecycle functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupTheme()
    }
    
}

//MARK: Exposed functions
extension LandingVCTableViewCell {
    
    /// Helps to configure cell.
    /// - Parameter data: Provide ''People' instance to populate the cell.
    func configure(data: Person) {
        name.text = data.name
        phone.text = data.phone
        website.text = data.website
        company.text = data.company?.name
        updateLike(status: defaults?.bool(forKey: "\(data.id)") ?? false)
    }
    
}

//MARK: Private utility functions
extension LandingVCTableViewCell {
    
    /// Helps to set up text or images.
    private func setupUI() {
    }
    
    /// Helps to setup ui fonts and colors.
    private func setupTheme() {
        //Cell content
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        //Contanier view
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = Constants.primaryColor.cgColor
        self.containerView.layer.borderWidth = 1
        
        //font
        fonting()

        self.company.textColor = Constants.primaryColor
    }
    
    private func fonting() {
        //BOLD 20
        Font.set(labels: [name], type: .bold, size: 20)
        
        //Regular 16
        Font.set(labels: [phone, website], type: .regular, size: 16)
        
        //Medium 16
        Font.set(labels: [company], type: .medium, size: 16)
        
    }
    
    private func updateLike(status: Bool) {
        like.image = status ? UIImage(named: "ic_favourite_filled") : UIImage(named: "ic_favourite_holo")
        
    }
    
}
