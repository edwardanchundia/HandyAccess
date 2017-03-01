//
//  Parks.swift
//  HandyAccess
//
//  Created by Karen Fuentes on 2/17/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import Foundation
struct Parks {
    var name: String
    var location: String
    var type: String
}
//var arrayOfParks = [Park]()
//override func viewDidLoad() {
//    super.viewDidLoad()
//    getData()
//    
//}
//
//func getData() {
//    APIRequestManager.manager.getData(endPoint: "https://data.cityofnewyork.us/resource/4xyq-5bdm.json") { (data: Data?) in
//        if let validData = data {
//            do {
//                let jsonData: Any = try JSONSerialization.jsonObject(with:validData, options: [])
//                guard let response = jsonData as? [[String: Any]] else { return }
//                for parkDict in response {
//                    if  let location = parkDict["location"] as? String,
//                        let name = parkDict["name"] as? String,
//                        let type = parkDict["type"] as? String {
//                        let park = Park(name: name, location: location, type: type)
//                        self.arrayOfParks.append(park)
//                        
//                    }
//                }
//            }
//            catch {
//                print(error)
//            }
//        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//}
