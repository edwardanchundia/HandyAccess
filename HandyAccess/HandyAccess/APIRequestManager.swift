//
//  APIRequestManager.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import Foundation

enum SocialServiceParseError: Error {
    case json
    case meta
    case view
    case columns
    case data
    case resource0
    case socialServices1
}

enum CoordinatesParseError: Error {
    case json
    case results
    case response
    case coordinates
    case location
}

class APIRequestManager {
    
    static let shared = APIRequestManager()
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping (Data?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
    
    func getSocialServices1(endPoint: String, callback: @escaping([SocialService1]?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            
            //dump(validData)
            
            var socialServices1 = [SocialService1]()
            do {
                guard let jsonArray = try JSONSerialization.jsonObject(with: validData, options: []) as? [[String: Any]] else {
                    throw SocialServiceParseError.json
                }
                
                for resource in jsonArray{
                    guard let s = SocialService1(withDict: resource) else {
                        continue
                    }
                    socialServices1.append(s)
                }
                //dump(socialServices1)
            }                
            catch SocialServiceParseError.json {
                print("SocialServiceParseError.json")
            }
            catch SocialServiceParseError.socialServices1 {
                print("SocialServiceParseError.socialServices1")
            }
            catch {
                print(error)
            }
            
            callback(socialServices1)
            }.resume()
    }
    
    func getSocialServicesViews(endPoint: String, callback: @escaping ([MetaView]?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            
            var metaViews = [MetaView]()
            do {
                guard let json = try JSONSerialization.jsonObject(with: validData, options: []) as? [String: Any] else {
                    throw SocialServiceParseError.json
                }
                guard let meta = json["meta"] as? [String: Any] else {
                    throw SocialServiceParseError.meta
                }
                guard let view = meta["view"] as? [String: Any] else {
                    throw SocialServiceParseError.view
                }
                guard let columns = view["columns"] as? [[String: Any]] else {
                    throw SocialServiceParseError.columns
                }
                
                for column in columns {
                    let v = MetaView(dict: column)
                    metaViews.append(v)
                }
            }
            catch SocialServiceParseError.meta {
                print("SocialServiceParseError.meta")
            }
            catch SocialServiceParseError.json {
                print("SocialServiceParseError.json")
            }
            catch SocialServiceParseError.view {
                print("SocialServiceParseError.view")
            }
            catch SocialServiceParseError.columns {
                print("SocialServiceParseError.columns")
            }
            catch {
                print(error)
            }
            
            callback(metaViews)
            }.resume()
    }
    
    func getSocialServicesData(endPoint: String, metaViews: [MetaView], callback: @escaping ([SocialService]?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            
            var socialServices = [SocialService]()
            do {
                guard let json = try JSONSerialization.jsonObject(with: validData, options: []) as? [String: Any] else {
                    throw SocialServiceParseError.json
                }
                guard let resoucesData = json["data"] as? [[Any]] else {
                    throw SocialServiceParseError.data
                }
                for resource in resoucesData{
                   let s = SocialService(array: resource)
                   socialServices.append(s)
                }
            }
            catch SocialServiceParseError.data {
                print("SocialServiceParseError.data")
            }
            catch SocialServiceParseError.json {
                print("SocialServiceParseError.json")
            }
            catch {
                print(error)
            }
            
            callback(socialServices)
            }.resume()
    }
    
    internal func getDataForCoordinates(address:String, borough: String, callback: @escaping([Coordinates]?) -> Void) {
        
        guard let validURL = URL(string: "https://api.cityofnewyork.us/geoclient/v1/search.json?app_id=1a4ac0f9&app_key=f6ecb3c64c54ece79b4667cae7ed96ad&input=%2031-00%2047th%20Ave%20queens") else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: validURL) { (data:Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print(error)
            }
            guard let validData = data else { return }
            
            var coordinatesArray = [Coordinates]()
            
            do {
                guard let validJson = try JSONSerialization.jsonObject(with: validData, options: []) as? [String: Any] else {
                    throw CoordinatesParseError.json
                }
                
                guard let resultsDict = validJson["results"] as? [[String: Any]] else {
                    throw CoordinatesParseError.results
                }
                
                for result in resultsDict{
                    guard let response = result["response"] as? [String: Any] else {
                        throw CoordinatesParseError.response
                    }
                    guard let c = Coordinates(with: response) else { continue }
                    coordinatesArray.append(c)
                }
            }
            catch CoordinatesParseError.json {
                print("CoordinatesParseError.json")
            }
            catch CoordinatesParseError.results {
                print("CoordinatesParseError.results")
            }
            catch {
                print(error)
            }
            
            //dump(coordinatesArray)
            
            callback(coordinatesArray)
            
            }.resume()
    }
    
    //Documentation
    //https://developers.google.com/maps/documentation/geocoding/start
    func getCoordinateFromGoogle(companyName: String, borough: String , complete: @escaping ([Coordinates]?) -> Void) {
        //https://maps.googleapis.com/maps/api/geocode/json?address=Woodside+on+the+move+NY&key=AIzaSyCJRwsd2ho13mhWQUrvi7AOXIbBMgBPLsY
        let validAddressSearchValue = (companyName + " " + borough).googleGeocodingSearchValue
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(validAddressSearchValue)+NY&key=AIzaSyCJRwsd2ho13mhWQUrvi7AOXIbBMgBPLsY"
        guard let validURL = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: validURL) { (data:Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print(error)
            }
            guard let validData = data else { return }
            
            var coordinatesArray = [Coordinates]()
            
            do {
                guard let validJson = try JSONSerialization.jsonObject(with: validData, options: []) as? [String: Any] else {
                    throw CoordinatesParseError.json
                }
                //                let json = try JSONSerialization.jsonObject(with: validData, options: []) as? Any
                //                guard let validJson = json as? [String: Any] else {
                //                    throw CoordinatesParseError.json
                //                }
                
                guard let resultsDict = validJson["results"] as? [[String: Any]] else {
                    throw CoordinatesParseError.results
                }
                
                for result in resultsDict{
                    guard let geometry = result["geometry"] as? [String: Any] else {
                        throw CoordinatesParseError.response
                    }
                    guard let location = geometry["location"] as? [String: Any] else {
                        throw CoordinatesParseError.location
                    }
                    guard let lat = location["lat"] as? Double,
                        let lng = location["lng"] as? Double else {
                            throw CoordinatesParseError.coordinates
                    }
                    let c = Coordinates(lat: lat, long: lng)
                    coordinatesArray.append(c)
                }
            }
            catch CoordinatesParseError.json {
                print("CoordinatesParseError.json")
            }
            catch CoordinatesParseError.results {
                print("CoordinatesParseError.results")
            }
            catch {
                print(error)
            }
            
            //dump(coordinatesArray)
            
            complete(coordinatesArray)
            
            }.resume()
    }

}
