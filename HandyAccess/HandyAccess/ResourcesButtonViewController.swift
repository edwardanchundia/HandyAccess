//
//  ResourcesButtonViewController.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/21/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit

class ResourcesButtonViewController: UIViewController, UIScrollViewDelegate {

    let boroughsDict = ["Queens":"Queens",
                        "Brooklyn":"Brooklyn",
                        "Bronx":"Bronx",
                        "Manhatttan":"Manhattan",
                        "Staten Island":"Staten_island",
                        "All":"All" ]
    let categoriesDict = ["aging" : "aging",
                          "counseling support" : "counseling_support_groups",
                          "disabilities" : "disabilities",
                          "education" : "education",
                          "health" : "health",
                          "housing" : "housing",
                          "immigration" : "immigration",
                          "job training" : "employment_job_training",
                          "legal services" : "legal_services",
                          "veterans" : "veterans_military_families",
                          "victim services" : "victim_services",
                          "youth services" : "youth_services"]
    var urlComponents = ["borough": " ", "category": " "]
    let color = ColorScheme()
    
    var allBoroughButtons: [UIButton] {
        get {
            return [queensButton, brooklynButton, bronxButton, statenIslandButton, manhattanButton, allButton]
        }
    }
    
    var allCategoryButtons: [UIButton] {
        get {
            return [housingButton, healthButton, educationButton, employmentButton, verteransButton, disabilitiesButton]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = color._50
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = color._50
        setupViewHierarchy()
        configureConstraints()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        view.addSubview(blur)
        view.addSubview(boroughContainer)
        view.addSubview(resourcesScrollView)
        
        boroughContainer.addSubview(boroughLabel)
        boroughContainer.addSubview(queensButton)
        boroughContainer.addSubview(brooklynButton)
        boroughContainer.addSubview(bronxButton)
        boroughContainer.addSubview(statenIslandButton)
        boroughContainer.addSubview(manhattanButton)
        boroughContainer.addSubview(allButton)
        
        resourcesScrollView.addSubview(resourceLabel)
        resourcesScrollView.addSubview(housingButton)
        resourcesScrollView.addSubview(healthButton)
        resourcesScrollView.addSubview(educationButton)
        resourcesScrollView.addSubview(employmentButton)
        resourcesScrollView.addSubview(verteransButton)
        resourcesScrollView.addSubview(disabilitiesButton)
        resourcesScrollView.addSubview(goButton)

    }
    
    private func configureConstraints() {
        blur.snp.makeConstraints({ (view) in
            view.top.bottom.trailing.leading.equalToSuperview()
        })
        
        setupContrainers()
    }
    

    func boroughButtonPressed(button: UIButton) {
        
        button.showsTouchWhenHighlighted = true
        
        for b in self.allBoroughButtons {
            if b == button {
                b.backgroundColor = color._200
            } else {
                b.backgroundColor = color._50
            }
            
        }

        guard let validButtonTitle = button.titleLabel?.text else { return }
        guard let validBorough = self.boroughsDict[validButtonTitle] else { return }
        self.urlComponents["borough"] = validBorough
    }
    
    func resourcesCategoryButtonPressed(button: UIButton) {

        button.showsTouchWhenHighlighted = true
        

        for b in self.allCategoryButtons {
            if b == button {
                b.backgroundColor = color._200
            } else {
                b.backgroundColor = color._50
            }
        }

        guard let validResourcesCategoryTitle = button.titleLabel?.text else { return }
        guard let validCategory = self.categoriesDict[validResourcesCategoryTitle.lowercased()] else { return }
        self.urlComponents["category"] = validCategory
    }
    
    func goButtonPressed(button: UIButton) {
        dump(self.urlComponents)
        for (key, value) in self.urlComponents {
            if value == " " {
                let alertController = UIAlertController(title: "Opps!", message: "Please select a borough and a category", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        dump(self.urlComponents)
        let socialServicesTableViewController = SocialServicesTableViewController()
        socialServicesTableViewController.urlComponents = self.urlComponents
        self.navigationController?.pushViewController(socialServicesTableViewController, animated: true)
    }

    func setupContrainers() {
        self.edgesForExtendedLayout = []
        
        boroughContainer.snp.makeConstraints({ (view) in
            view.top.equalTo(self.view.snp.top).offset(20)
            view.centerX.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.4)
            view.width.equalToSuperview().multipliedBy(0.9)
        })
        //boroughContainer.isHidden = true
        
        boroughLabel.snp.makeConstraints({ (view) in
            view.top.equalTo(boroughContainer.snp.top).offset(20)
            view.centerX.equalTo(boroughContainer.snp.centerX)
        })
        
        queensButton.snp.makeConstraints({ (view) in
            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
            view.top.equalTo(boroughLabel.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        brooklynButton.snp.makeConstraints({ (view) in
            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
            view.top.equalTo(queensButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        bronxButton.snp.makeConstraints({ (view) in
            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
            view.top.equalTo(brooklynButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        statenIslandButton.snp.makeConstraints({ (view) in
            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
            view.top.equalTo(boroughLabel.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        manhattanButton.snp.makeConstraints({ (view) in
            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
            view.top.equalTo(statenIslandButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        allButton.snp.makeConstraints({ (view) in
            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
            view.top.equalTo(manhattanButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        resourcesScrollView.snp.makeConstraints({ (view) in
            view.top.equalTo(self.boroughContainer.snp.bottom).offset(10)
            view.leading.equalTo(boroughContainer.snp.leading)
            view.height.equalToSuperview().multipliedBy(0.6)
            view.width.equalToSuperview().multipliedBy(0.9)
            //            view.width.equalTo(1000)
        })
        //resourcesScrollView.isHidden = true
        
        resourceLabel.snp.makeConstraints({ (view) in
            view.top.equalTo(resourcesScrollView.snp.top).offset(20)
            view.centerX.equalTo(boroughContainer.snp.centerX)
        })
        
        employmentButton.snp.makeConstraints({ (view) in
            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
            view.top.equalTo(resourceLabel.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        disabilitiesButton.snp.makeConstraints({ (view) in
            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
            view.top.equalTo(employmentButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        housingButton.snp.makeConstraints({ (view) in
            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
            view.top.equalTo(disabilitiesButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        educationButton.snp.makeConstraints({ (view) in
            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
            view.top.equalTo(resourceLabel.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        verteransButton.snp.makeConstraints({ (view) in
            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
            view.top.equalTo(educationButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        healthButton.snp.makeConstraints({ (view) in
            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
            view.top.equalTo(verteransButton.snp.bottom).offset(20)
            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            view.height.equalTo(45)
        })
        
        goButton.snp.makeConstraints({(button) in
            button.centerX.equalToSuperview()
            button.top.equalTo(housingButton.snp.bottom).offset(20)
            button.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
            button.height.equalTo(45)
        })
    }

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
    
    internal lazy var boroughContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.brown
        return view
    }()
    
    internal lazy var boroughLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a borough..."
        return label
    }()
    
    internal lazy var queensButton: UIButton = {
        let button = UIButton()
        button.setTitle("Queens", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var brooklynButton: UIButton = {
        let button = UIButton()
        button.setTitle("Brooklyn", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var bronxButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bronx", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        //        button.backgroundColor?.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var statenIslandButton: UIButton = {
        let button = UIButton()
        button.setTitle("Staten Island", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var manhattanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Manhattan", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle("All", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var resourcesScrollView: UIView = {
        let view = UIView()
        //        scrollView.gestureRecognizerShouldBegin(true)
        //view.backgroundColor = UIColor.blue
        return view
    }()
    
    internal lazy var resourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Resource..."
        return label
    }()
    
    internal lazy var housingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Housing", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var healthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Health", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var educationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Education", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var employmentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Employment", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var verteransButton: UIButton = {
        let button = UIButton()
        button.setTitle("Veterans", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var disabilitiesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Disabilities", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var goButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("Go", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        var blurEffectView = UIVisualEffectView(effect: blur)
        return blurEffectView
    }()

}
