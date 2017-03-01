//
//  SocialServicesDetailViewController.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/19/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit

class SocialServicesDetailViewController: UIViewController {
    
    var socialService1: SocialService1?
    var borough: String?
    var coordinates: Coordinates?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        configureConstraints()
        self.view.backgroundColor = UIColor.white
        
        self.organizationNameLabel.text = socialService1?.organizationname
        self.descriptionLabel.text = socialService1?.description
       
        if let validSocialService1 = self.socialService1 {
            if let validCoordinate = validSocialService1.location_1 {
                self.coordinates = validCoordinate
            } else {
                guard let borough = self.borough else { return }
                APIRequestManager.shared.getCoordinateFromGoogle(companyName: validSocialService1.organizationname, borough: borough) { (coordinatesArr:[Coordinates]?) in
                    DispatchQueue.main.async {
                        guard let validCoordinatesArr = coordinatesArr else { return }
                        guard validCoordinatesArr.count > 0 else { return }
                        self.coordinates = validCoordinatesArr[0]
                    }
                }
            }
        }
    }
    
    private func setupViewHierarchy() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(organizationNameLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(openInMapButton)
        self.contentView.addSubview(makeACallButton)
    }
    
    private func configureConstraints() {
    
        scrollView.snp.makeConstraints { (view) in
            view.top.equalTo(self.topLayoutGuide.snp.bottom)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (view) in
            view.top.leading.trailing.bottom.equalToSuperview()
            view.width.equalTo(self.view.snp.width)
        }
        
        organizationNameLabel.snp.makeConstraints { (label) in
            
            label.top.equalToSuperview().offset(16)
            label.leading.equalToSuperview().offset(16)
            label.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { (label) in
            
            label.top.equalTo(self.organizationNameLabel.snp.bottom).offset(16)
            label.leading.equalToSuperview().offset(16)
            label.trailing.equalToSuperview().inset(16)
        }
        
        openInMapButton.snp.makeConstraints { (button) in
            
            button.top.equalTo(self.descriptionLabel.snp.bottom).offset(16)
            button.centerX.equalToSuperview()
        }
        
        makeACallButton.snp.makeConstraints { (button) in
            
            button.top.equalTo(self.openInMapButton.snp.bottom).offset(16)
            button.centerX.equalToSuperview()
            button.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Target Functions
    func openInMap() {
        if let validCoordinates = self.coordinates {
            let socialServicesMapViewController = SocialServicesMapViewController()
            socialServicesMapViewController.coordinates = validCoordinates
            socialServicesMapViewController.socialService1 = self.socialService1
            self.navigationController?.pushViewController(socialServicesMapViewController, animated: true)
        }
    }
    
    func makeACall() {
        guard let validPhone = self.socialService1?.phone else { return }
        let phoneNumber: String = "tel://\(validPhone)"
        UIApplication.shared.open(URL(string: phoneNumber)!, options: [:], completionHandler: nil)
    }
    
    // MARK: - Lazy Vars
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var organizationNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: 8)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization Description"
        label.font = UIFont.systemFont(ofSize: 16, weight: 6)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var openInMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Locate on Map", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        //<a href="https://icons8.com/web-app/30563/Map-Marker">
        button.imageView?.image = #imageLiteral(resourceName: "Map Marker-50")
        button.addTarget(self, action: #selector(openInMap), for: .touchUpInside)
        return button
    }()

    lazy var makeACallButton: UIButton = {
        let button = UIButton()
        button.setTitle("Call Company", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(makeACall), for: .touchUpInside)
        return button
    }()
    
}
