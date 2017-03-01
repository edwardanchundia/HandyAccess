//
//  SocialServicesTableViewController.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit

class SocialServicesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let colorScheme = ColorScheme()
    
    var socialServices1 = [SocialService1]()
    let endpoint = "https://data.cityofnewyork.us/resource/386y-9exk.json?Queens=Y&aging=Y"
    //    var metaViews = [MetaView]()
    //    var socialServices = [SocialService]()
    //    let endpoint = "https://data.cityofnewyork.us/api/views/69bm-3bc2/rows.json?accessType=DOWNLOAD"
    
    var pickerSelections = [[String]]()
    let boroughsDict = ["Queens":"Queens",
                        "Brooklyn":"Brooklyn",
                        "Bronx":"Bronx",
                        "Manhatttan":"Manhattan",
                        "Staten Island":"Staten_island",
                        "All":"All" ]
    let categoriesDict = ["Aging" : "aging",
                          "Counseling Support" : "counseling_support_groups",
                          "Disabilities" : "disabilities",
                          "Education" : "education",
                          "Health" : "health",
                          "Housing" : "housing",
                          "Immigration" : "immigration",
                          "Job Training" : "employment_job_training",
                          "Legal Services" : "legal_services",
                          "Veterans" : "veterans_military_families",
                          "Victim Services" : "victim_services",
                          "Youth Services" : "youth_services"]
    /*
                      "anti_discrimination_human_rights",
                      "arts_culture",
                      "business",
                      "child_care_parent_information",
                      "community_service_volunteerism",
                      "domestic_violence",
                      "employment_job_training",
                      "Homelessness" : "homelessness",
                      "lesbian_gay_bisexual_and_or_transgender",
                      "new_york_city_agency",
                      "Nonprofit" : "nonprofit",
                      "none_of_the_above",
                      //??"nourl",
                      "other_government_organization",
                      "outsideloc",
                      "personal_finance_financial_education",
                      "professional_association",
    */
    var urlComponents = ["borough": "Queens", "category": "aging"] {
        didSet {
            let url = buildUrlWithComponent(self.urlComponents)
            APIRequestManager.shared.getSocialServices1(endPoint: url) { (socialServices1: [SocialService1]?) in
                guard let validSocialServices1 = socialServices1 else { return }
                DispatchQueue.main.async {
                    self.socialServices1 = validSocialServices1
                    self.socialSourceTableView.reloadData()
                }
            }
        }
    }
    
    var titleComponents : [String: String] {
        get {
            var titleBorough = ""
            var titleCategory = ""
            for (key, value) in categoriesDict {
                if let category = urlComponents["category"], value == category {
                    titleCategory = key
                }
            }
            for (key, value) in boroughsDict {
                if let borough = urlComponents["borough"], value == borough {
                    titleBorough = key
                }
            }
            return ["borough" : "\(titleBorough)", "category" : "\(titleCategory)"]
        }
    }
    var catagoryKeys : [String] {
        get  {
            return self.categoriesDict.map{$0.key}.sorted(by: <)
        }
    }
    var boroughKeys : [String] {
        get {
            return self.boroughsDict.map{$0.key}.sorted(by: >)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        configureConstraints()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        if let category = titleComponents["category"], let borough = titleComponents["borough"] {
            self.title = "\(borough) \(category)"
        }
        let url = buildUrlWithComponent(self.urlComponents)
        APIRequestManager.shared.getSocialServices1(endPoint: url) { (socialServices: [SocialService1]?) in
            guard let validSocialServices = socialServices else { return }
            DispatchQueue.main.async {
                self.socialServices1 = validSocialServices
                self.socialSourceTableView.reloadData()
                //dump(self.socialServices1)
            }
        }
        
        self.socialSourceTableView.register(SocialServiceTableViewCell.self, forCellReuseIdentifier: SocialServiceTableViewCell.cellIdentifier)
        
        pickerSelections = [self.boroughKeys, self.catagoryKeys]
    }
    
    private func setupViewHierarchy() {
        self.view.addSubview(self.filterPicker)
        self.view.addSubview(self.socialSourceTableView)
    }
    
    private func configureConstraints() {
        self.filterPicker.backgroundColor = self.colorScheme._50
        self.filterPicker.snp.makeConstraints{ (view) in
            view.top.equalTo(self.topLayoutGuide.snp.bottom)
            view.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.2)
        }
        
        self.socialSourceTableView.snp.makeConstraints { (view) in
            view.top.equalTo(self.filterPicker.snp.bottom)
            view.leading.trailing.equalToSuperview()
            view.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
    
    // MARK: - TableView data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.socialServices1.count)
        return self.socialServices1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SocialServiceTableViewCell.cellIdentifier, for: indexPath) as! SocialServiceTableViewCell
        
        let socialService = socialServices1[indexPath.row]
        cell.organizationNameLabel.text = socialService.organizationname
        cell.organizationDescriptionLabel.text = socialService.description
        
        if let urlString = socialService.url,
            let url = URL(string: urlString) {
            //Do Stuff
        }
        cell.backgroundColor = self.colorScheme.colorSchemeArr[indexPath.row % self.colorScheme.colorSchemeArr.count]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let socialServicesDetailViewController = SocialServicesDetailViewController()
        socialServicesDetailViewController.socialService1 = socialServices1[indexPath.row]
        socialServicesDetailViewController.borough = self.urlComponents["borough"]
        self.navigationController?.pushViewController(socialServicesDetailViewController, animated: true)
    }
    
    // MARK: - PickerView Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.pickerSelections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerSelections[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont.systemFont(ofSize: 16)
            pickerLabel?.numberOfLines = 0
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = pickerSelections[component][row]
        
        switch component {
        case 0:
            pickerLabel?.backgroundColor = self.colorScheme._100
            //pickerLabel?.backgroundColor = self.colorScheme.colorSchemeArrPickerViewBorough[row % self.colorScheme.colorSchemeArrPickerViewBorough.count]
        case 1:
            pickerLabel?.backgroundColor = self.colorScheme._300
             //pickerLabel?.backgroundColor = self.colorScheme.colorSchemeArrPickerViewCategories[row % self.colorScheme.colorSchemeArrPickerViewCategories.count]
        default:
            break
        }
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.urlComponents["borough"] = self.boroughsDict[self.boroughKeys[row]]
        case 1:
            self.urlComponents["category"] = self.categoriesDict[self.catagoryKeys[row]]
        default:
            break
        }
        let url = buildUrlWithComponent(self.urlComponents)
        APIRequestManager.shared.getSocialServices1(endPoint: url) { (socialServices1: [SocialService1]?) in
            guard let validSocialServices1 = socialServices1 else { return }
            DispatchQueue.main.async {
                self.socialServices1 = validSocialServices1
                self.socialSourceTableView.reloadData()
            }
        }
    }
    
    func buildUrlWithComponent(_ dict: [String: String]) -> String {
        var base = "https://data.cityofnewyork.us/resource/386y-9exk.json?"
        for value in dict.values {
            if value != "All" {
                base += "\(value)=Y&"
            }
        }
        print(base)
        return base
    }
    
    lazy var filterBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Filter"
        return barButton
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var filterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var socialSourceTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = self.colorScheme._50
        return tableView
    }()
    
}
