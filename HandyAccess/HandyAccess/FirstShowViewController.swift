//
//  FirstShowViewController.swift
//  HandyAccess
//
//  Created by Edward Anchundia on 2/21/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit

class FirstShowViewController: UIViewController {
    
    let color = ColorScheme()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color._50
        self.navigationController?.isNavigationBarHidden = true

        setupViewHierarchy()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        view.addSubview(blur)
        view.addSubview(speechOrButtonContainer)
        view.addSubview(resourcesOrNearBy)
        
        speechOrButtonContainer.addSubview(speechOrClickLabel)
        speechOrButtonContainer.addSubview(speechButtonForContainer)
        speechOrButtonContainer.addSubview(clickButtonsForContainer)
        
        resourcesOrNearBy.addSubview(resourcesOrNearbyLabel)
        resourcesOrNearBy.addSubview(resoucesButton)
        resourcesOrNearBy.addSubview(mapResoucesButton)
    }
    
    func setupView() {
        blur.snp.makeConstraints({ (view) in
            view.top.bottom.trailing.leading.equalToSuperview()
        })
        
        speechAndButtonContainer()
        resourcesOrNearbyPlace()
    }
    
    func buttonPressed(button: UIButton) {
        button.showsTouchWhenHighlighted = true
        switch button {
            //        case speechButtonForContainer:
        //            print("Speech Button pressed")
        case clickButtonsForContainer:
            print("Want buttons")
            fadeOutView(view: speechOrButtonContainer, hidden: true)
            fadeInView(view: resourcesOrNearBy, hidden: true)
        case speechButtonForContainer:
            let initialVC = InitialViewController()
            self.navigationController?.pushViewController(initialVC, animated: true)
        case resoucesButton:
//            fadeOutView(view: resourcesOrNearBy, hidden: true)
            fadeOutView(view: resourcesOrNearBy, hidden: true)
            fadeInView(view: speechOrButtonContainer, hidden: true)

            let resoucesButtonVC = ResourcesButtonViewController()
            
            self.navigationController?.pushViewController(resoucesButtonVC, animated: true)
        case mapResoucesButton:
//            let mapView = MapViewController()
//            let mapButtonVC = MapButtonViewController()
//            mapButtonVC.setMapController(map1: mapView)
//            self.navigationController?.pushViewController(mapButtonVC, animated: true)
            fadeOutView(view: resourcesOrNearBy, hidden: true)
            fadeInView(view: speechOrButtonContainer, hidden: true)
            let mapVC = MapViewController()
            self.navigationController?.pushViewController(mapVC, animated: true)
            
//            fadeInView(view: boroughContainer, hidden: true)
//            fadeInView(view: resourcesScrollView, hidden: true)
//        case mapResoucesButton:
//            fadeOutView(view: resourcesOrNearBy, hidden: true)
//            fadeInView(view: mitiButtonContainer, hidden: true)
        default:
            break
        }
    }
    
    func speechAndButtonContainer() {
        speechOrButtonContainer.snp.makeConstraints({ (view) in
            view.center.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.3)
            view.width.equalToSuperview().multipliedBy(0.8)
        })
        
        speechOrClickLabel.snp.makeConstraints({ (view) in
            view.top.equalTo(speechOrButtonContainer.snp.top).offset(20)
            view.centerX.equalTo(speechOrButtonContainer.snp.centerX)
        })
        
        clickButtonsForContainer.snp.makeConstraints({ (view) in
            view.top.equalTo(speechOrClickLabel.snp.bottom).offset(20)
            view.width.equalTo(speechOrButtonContainer.snp.width).multipliedBy(0.8)
            view.centerX.equalTo(speechOrButtonContainer.snp.centerX)
            view.height.equalTo(45)
        })
        
        speechButtonForContainer.snp.makeConstraints({ (view) in
            view.top.equalTo(clickButtonsForContainer.snp.bottom).offset(20)
            view.width.equalTo(speechOrButtonContainer.snp.width).multipliedBy(0.8)
            view.centerX.equalTo(speechOrButtonContainer.snp.centerX)
            view.height.equalTo(45)
        })
    }
    
    func resourcesOrNearbyPlace() {
        resourcesOrNearBy.snp.makeConstraints({ (view) in
            view.center.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.3)
            view.width.equalToSuperview().multipliedBy(0.8)
        })
        resourcesOrNearBy.isHidden = true
        
        resourcesOrNearbyLabel.snp.makeConstraints({ (view) in
            view.top.equalTo(resourcesOrNearBy.snp.top).offset(20)
            view.centerX.equalTo(resourcesOrNearBy.snp.centerX)
        })
        
        resoucesButton.snp.makeConstraints({ (view) in
            view.top.equalTo(resourcesOrNearbyLabel.snp.bottom).offset(20)
            view.width.equalTo(resourcesOrNearBy.snp.width).multipliedBy(0.8)
            view.centerX.equalTo(resourcesOrNearBy.snp.centerX)
            view.height.equalTo(45)
        })
        
        mapResoucesButton.snp.makeConstraints({ (view) in
            view.top.equalTo(resoucesButton.snp.bottom).offset(20)
            view.width.equalTo(resourcesOrNearBy.snp.width).multipliedBy(0.8)
            view.centerX.equalTo(resourcesOrNearBy.snp.centerX)
            view.height.equalTo(45)
        })
    }
    
    //MARK: ANIMATION
    func fadeOutView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {() -> Void in
            view.isHidden = true
        }, completion: { _ in })
    }
    
    func fadeInView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {() -> Void in
            view.isHidden = false
        }, completion: { _ in })
    }

    
    //MARK: START UP CONTAINER - SPEECH OR SIGHT
    internal lazy var speechOrButtonContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.brown
        return view
    }()
    
    internal lazy var speechOrClickLabel: UILabel = {
        let label = UILabel()
        label.text = "How would you like to navigate?"
        return label
    }()
    
    internal lazy var speechButtonForContainer: UIButton = {
        let button = UIButton()
        button.setTitle("Sound", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var clickButtonsForContainer: UIButton = {
        let button = UIButton()
        button.setTitle("Sight", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: SECOND CONTAINER - RESOURCES OR MAP RESOURCES
    internal lazy var resourcesOrNearBy: UIView = {
        let view = UIView()
        //        view.backgroundColor = UIColor.blue
        return view
    }()
    
    internal lazy var resourcesOrNearbyLabel: UILabel = {
        let label = UILabel()
        label.text = "Pick resouces or nearby"
        return label
    }()
    
    internal lazy var resoucesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resources", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var mapResoucesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Map resources", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        var blurEffectView = UIVisualEffectView(effect: blur)
        return blurEffectView
    }()
}
