//
//  NYCEventCalendarModel.swift
//  HandyAccess
//
//  Created by Edward Anchundia on 2/17/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import Foundation

enum NYCEventCalendarModelParseError: Error {
    case json
    case eventsArray
    case date
    case time
    case cancelled
    case link
    case name
    case description
    case address
    case geo
}

class NYCEventCalendarModel {
    let date: String?
    let time: String?
    let cancelled: Bool?
    let link: String?
    let name: String?
    let description: String?
    let address: String?
    let geo: [String: Any]?
    
    init(with eventDict: [String: Any]) {
        self.date = eventDict["datePart"] as? String ?? ""
        self.time = eventDict["timePart"] as? String ?? ""
        self.cancelled = eventDict["canceled"] as? Bool ?? nil
        self.link = eventDict["permalink"] as? String ?? ""
        self.name = eventDict["name"] as? String ?? ""
        self.description = eventDict["shortDesc"] as? String ?? ""
        self.address = eventDict["address"] as? String ?? ""
        self.geo = eventDict["geometry"] as? [String: Any] ?? nil
    }
    
    static func getEvents(from data: Data) -> [NYCEventCalendarModel]? {
        var events: [NYCEventCalendarModel] = []
        do {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dictContainingEvents = json as? [String: Any] else {
                throw NYCEventCalendarModelParseError.json
            }
            guard let eventsArray = dictContainingEvents["items"] as? [[String: Any]] else {
                throw NYCEventCalendarModelParseError.eventsArray
            }
            for eventDict in eventsArray {
                events.append(NYCEventCalendarModel(with: eventDict))
            }
        } catch NYCEventCalendarModelParseError.eventsArray {
            print("NYCEventCalendarModelParseError.eventsArray")
        } catch NYCEventCalendarModelParseError.json {
            print("NYCEventCalendarModelParseError.json")
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
    
}
