//
//  LandingVC.swift
//  People
//
//  Created by Nitesh Vishwakarma on 13/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class LandingVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    
    /// Presenter is responsible to perform task.
    var presenter: LandingPresenterProtocol?
    
    /// Used for loading purposes.
    private var activityLoader: UIActivityIndicatorView?
    
    /// Used for loading purposes.
    private var activityView: UIView?

    /// LandingVCTableViewCell string.
    private let cellName = "LandingVCTableViewCell"
    
    //MARK: Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
}

//MARK: Private utility functions
extension LandingVC {
    
    /// Helps to configure the view controller.
    private func configure() {
        setupTableView()
        setupTheme()
    }
    
    /// Helps to setup table view with delegates and datasources.
    private func setupTableView() {
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    
    /// Helps to setup fonts and themes of the view controller.
    private func setupTheme() {
        //Navigation bar
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.set(type: .medium, size: 20)]
        self.title = "Welcome to People"
    }
    
}

//MARK: Conforming to UITableView Delegates and Datasources.
extension LandingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.people?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? LandingVCTableViewCell, let data = presenter?.people?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetailing(index: indexPath.row)
    }
    
}

//MARK: Conforming to LandingVCProtocol.
extension LandingVC: LandingVCProtocol {
    
    func reloadTable() {
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] action in
                self?.presenter?.getUser()
                alert.dismiss(animated: true, completion: nil)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func startLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.activityLoader = UIActivityIndicatorView(style: .medium)
            self?.activityLoader?.hidesWhenStopped = false
            self?.activityLoader?.startAnimating()
            self?.activityView = UIView(frame: self?.view.frame ?? CGRect())
            self?.activityView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self?.activityView?.addSubview(self?.activityLoader ?? UIView())
            self?.activityView?.layer.cornerRadius = 10
            self?.activityLoader?.center = CGPoint(x: (self?.activityView?.frame.width ?? 0) / 2, y: (self?.activityView?.frame.height ?? 0) / 2)
            
            self?.view.addSubview(self?.activityView ?? UIView())
        }
    }
    
    func stopLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.activityLoader = nil
            self?.activityView?.removeFromSuperview()
        }
    }
    
}
