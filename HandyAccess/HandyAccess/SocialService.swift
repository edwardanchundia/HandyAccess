//
//  SocialService.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import Foundation

class Coordinates {
    var lat: Double
    var long: Double
    init(lat: Double, long: Double ) {
        self.lat = lat
        self.long = long
    }
    convenience init? (with array : [Double]?) {
        guard let validArray = array else { return nil }
        guard validArray.count == 2 else { return nil }
        self.init(lat: validArray[1], long: validArray[0])
    }
    
    convenience init? (with dict: [String: Any]) {
        if let lat = dict["latitude"] as? Double,
            let long = dict["longitude"] as? Double {
            self.init(lat: lat, long: long)
        } else {
            return nil
        }
    }
}

//https://data.cityofnewyork.us/resource/386y-9exk.json
class SocialService1 {
    var aging: String?
    var anti_discrimination_human_rights: String?
    var arts_culture: String?
    var bronx: String?
    var brooklyn: String?
    var business: String?
    var child_care_parent_information: String?
    var community_service_volunteerism: String?
    var counseling_support_groups: String?
    var description: String?
    var disabilities: String?
    var domestic_violence: String?
    var education: String?
    var employment_job_training: String?
    var faith_based_organization: String?
    var fax: String?
    var foundation: String?
    var health: String?
    var homelessness: String?
    var housing: String?
    var immigration: String?
    var is_registered_with_the_attorney_general_s_office: String?
    var legal_services: String?
    var lesbian_gay_bisexual_and_or_transgender: String?
    var location_1: Coordinates?
    var location_1_location: String?
    var location_1_zip: String?
    var location_2: Coordinates?
    var location_2_city: String?
    var location_2_location: String?
    var location_2_state: String?
    var location_2_zip: String?
    var manhattan: String?
    var new_york_city_agency: String?
    var none_of_the_above: String?
    var nonprofit: String?
    var nourl: String?
    var organizationname: String
    var other_government_organization: String?
    var outsideloc: String?
    var personal_finance_financial_education: String?
    var phone: String?
    var professional_association: String?
    var published: String?
    var queens: String?
    var staten_island: String?
    var url: String?
    var veterans_military_families: String?
    var victim_services: String?
    var youth_services: String?
    
    init(aging: String?,
         anti_discrimination_human_rights: String?,
         arts_culture: String?,
         bronx: String?,
         brooklyn: String?,
         business: String?,
         child_care_parent_information: String?,
         community_service_volunteerism: String?,
         counseling_support_groups: String?,
         description: String?,
         disabilities: String?,
         domestic_violence: String?,
         education: String?,
         employment_job_training: String?,
         faith_based_organization: String?,
         fax: String?,
         foundation: String?,
         health: String?,
         homelessness: String?,
         housing: String?,
         immigration: String?,
         is_registered_with_the_attorney_general_s_office: String?,
         legal_services: String?,
         lesbian_gay_bisexual_and_or_transgender: String?,
         location_1: Coordinates?,
         location_1_location: String?,
         location_1_zip: String?,
         location_2: Coordinates?,
         location_2_city: String?,
         location_2_location: String?,
         location_2_state: String?,
         location_2_zip: String?,
         manhattan: String?,
         new_york_city_agency: String?,
         none_of_the_above: String?,
         nonprofit: String?,
         nourl: String?,
         organizationname: String,
         other_government_organization: String?,
         outsideloc: String?,
         personal_finance_financial_education: String?,
         phone: String?,
         professional_association: String?,
         published: String?,
         queens: String?,
         staten_island: String?,
         url: String?,
         veterans_military_families: String?,
         victim_services: String?,
         youth_services: String?
        ) {
        self.aging = aging
        self.anti_discrimination_human_rights = anti_discrimination_human_rights
        self.arts_culture = arts_culture
        self.bronx = bronx
        self.brooklyn = brooklyn
        self.business = business
        self.child_care_parent_information = child_care_parent_information
        self.community_service_volunteerism = community_service_volunteerism
        self.counseling_support_groups = counseling_support_groups
        self.description = description
        self.disabilities = disabilities
        self.domestic_violence = domestic_violence
        self.education = education
        self.employment_job_training = employment_job_training
        self.faith_based_organization = faith_based_organization
        self.fax = fax
        self.foundation = foundation
        self.health = health
        self.homelessness = homelessness
        self.housing = housing
        self.immigration = immigration
        self.is_registered_with_the_attorney_general_s_office = is_registered_with_the_attorney_general_s_office
        self.legal_services = legal_services
        self.lesbian_gay_bisexual_and_or_transgender = lesbian_gay_bisexual_and_or_transgender
        self.location_1 = location_1
        self.location_1_location = location_1_location
        self.location_1_zip = location_1_zip
        self.location_2 = location_2
        self.location_2_city = location_2_city
        self.location_2_location = location_2_location
        self.location_2_state = location_2_state
        self.location_2_zip = location_2_zip
        self.manhattan = manhattan
        self.new_york_city_agency = new_york_city_agency
        self.none_of_the_above = none_of_the_above
        self.nonprofit = nonprofit
        self.nourl = nourl
        self.organizationname = organizationname
        self.other_government_organization = other_government_organization
        self.outsideloc = outsideloc
        self.personal_finance_financial_education = personal_finance_financial_education
        self.phone = phone
        self.professional_association = professional_association
        self.published = published
        self.queens = queens
        self.staten_island = staten_island
        self.url = url
        self.veterans_military_families = veterans_military_families
        self.victim_services = victim_services
        self.youth_services = youth_services
    }
    
    convenience init? (withDict dictionary: [String: Any]) {
        if let organizationname = dictionary["organizationname"] as? String {
                let aging = dictionary["aging"] as? String
                let anti_discrimination_human_rights = dictionary["anti_discrimination_human_rights"] as? String
                let arts_culture = dictionary["arts_culture"] as? String
                let bronx = dictionary["bronx"] as? String
                let brooklyn = dictionary["brooklyn"] as? String
                let business = dictionary["business"] as? String
                let child_care_parent_information = dictionary["child_care_parent_information"] as? String
                let community_service_volunteerism = dictionary["community_service_volunteerism"] as? String
                let counseling_support_groups = dictionary["counseling_support_groups"] as? String
                let description = dictionary["description"] as? String
                let disabilities = dictionary["disabilities"] as? String
                let domestic_violence = dictionary["domestic_violence"] as? String
                let education = dictionary["education"] as? String
                let employment_job_training = dictionary["employment_job_training"] as? String
                let faith_based_organization = dictionary["faith_based_organization"] as? String
                let fax = dictionary["fax"] as? String
                let foundation = dictionary["foundation"] as? String
                let health = dictionary["health"] as? String
                let homelessness = dictionary["homelessness"] as? String
                let housing = dictionary["housing"] as? String
                let immigration = dictionary["immigration"] as? String
                let is_registered_with_the_attorney_general_s_office = dictionary["is_registered_with_the_attorney_general_s_office"] as? String
                let legal_services = dictionary["legal_services"] as? String
                let lesbian_gay_bisexual_and_or_transgender = dictionary["lesbian_gay_bisexual_and_or_transgender"] as? String
            
                // location_1
                let location_1 = dictionary["location_1"] as? [String: Any]
                let location_1_coordinate_doubles = location_1?["coordinates"] as? [Double]
                let location_1_location = dictionary["location_1_location"] as? String
                let location_1_zip = dictionary["location_1_zip"] as? String
                // location_2
                let location_2 = dictionary["location_2"] as? [String: Any]
                let location_2_coordinate_doubles = location_2?["coordinates"] as? [Double]
                let location_2_city = dictionary["location_2_city"] as? String
                let location_2_location = dictionary["location_2_location"] as? String
                let location_2_state = dictionary["location_2_state"] as? String
                let location_2_zip = dictionary["location_2_zip"] as? String
            
                let manhattan = dictionary["manhattan"] as? String
                let new_york_city_agency = dictionary["new_york_city_agency"] as? String
                let none_of_the_above = dictionary["none_of_the_above"] as? String
                let nonprofit = dictionary["nonprofit"] as? String
                let nourl = dictionary["nourl"] as? String
                let other_government_organization = dictionary["other_government_organization"] as? String
                let outsideloc = dictionary["outsideloc"] as? String
                let personal_finance_financial_education = dictionary["personal_finance_financial_education"] as? String
                let phone = dictionary["phone"] as? String
                let professional_association = dictionary["professional_association"] as? String
                let published = dictionary["published"] as? String
                let queens = dictionary["queens"] as? String
                let staten_island = dictionary["staten_island"] as? String
                let url = dictionary["url"] as? String
                let veterans_military_families = dictionary["veterans_military_families"] as? String
                let victim_services = dictionary["victim_services"] as? String
                let youth_services = dictionary["youth_services"] as? String
            
                let location_1_coordinate_object = Coordinates.init(with: location_1_coordinate_doubles)
                let location_2_coordinate_object = Coordinates.init(with: location_2_coordinate_doubles)

            self.init(aging: aging,
                      anti_discrimination_human_rights: anti_discrimination_human_rights,
                      arts_culture: arts_culture,
                      bronx: bronx,
                      brooklyn: brooklyn,
                      business: business,
                      child_care_parent_information: child_care_parent_information,
                      community_service_volunteerism: community_service_volunteerism,
                      counseling_support_groups: counseling_support_groups,
                      description: description,
                      disabilities: disabilities,
                      domestic_violence: domestic_violence,
                      education: education,
                      employment_job_training: employment_job_training,
                      faith_based_organization: faith_based_organization,
                      fax: fax,
                      foundation: foundation,
                      health: health,
                      homelessness: homelessness,
                      housing: housing,
                      immigration: immigration,
                      is_registered_with_the_attorney_general_s_office: is_registered_with_the_attorney_general_s_office,
                      legal_services: legal_services,
                      lesbian_gay_bisexual_and_or_transgender: lesbian_gay_bisexual_and_or_transgender,
                      location_1: location_1_coordinate_object,
                      location_1_location: location_1_location,
                      location_1_zip: location_1_zip,
                      location_2: location_2_coordinate_object,
                      location_2_city: location_2_city,
                      location_2_location: location_2_location,
                      location_2_state: location_2_state,
                      location_2_zip: location_2_zip,
                      manhattan: manhattan,
                      new_york_city_agency: new_york_city_agency,
                      none_of_the_above: none_of_the_above,
                      nonprofit: nonprofit,
                      nourl: nourl,
                      organizationname: organizationname,
                      other_government_organization: other_government_organization,
                      outsideloc: outsideloc,
                      personal_finance_financial_education: personal_finance_financial_education,
                      phone: phone,
                      professional_association: professional_association,
                      published: published,
                      queens: queens,
                      staten_island: staten_island,
                      url: url,
                      veterans_military_families: veterans_military_families,
                      victim_services: victim_services,
                      youth_services: youth_services
            )
        }
        else {
            return nil
        }
    }
}

//https://data.cityofnewyork.us/resource/386y-9exk.json?aging=N
/*
 {
 aging: "N",
 anti_discrimination_human_rights: "N",
 arts_culture: "N",
 bronx: "N",
 brooklyn: "Y",
 business: "N",
 child_care_parent_information: "Y",
 community_service_volunteerism: "N",
 counseling_support_groups: "Y",
 description: "Established in 1858, the YWCA of the City of New York is one of the nationï¿½s oldest non-profit organizations. Our mission is to address the critical needs of New York City women and to empower them for success and leadership in their lives, jobs and communities. We focus on underserved families through job training, educational child care and after school programs; partnerships with business, government and other not-for-profits; and advocacy on behalf of the clients we serve.",
 disabilities: "N",
 domestic_violence: "N",
 education: "N",
 employment_job_training: "Y",
 faith_based_organization: "N",
 fax: "2122236438",
 foundation: "N",
 health: "N",
 homelessness: "N",
 housing: "N",
 immigration: "N",
 is_registered_with_the_attorney_general_s_office: "N",
 legal_services: "N",
 lesbian_gay_bisexual_and_or_transgender: "N",
 manhattan: "Y",
 new_york_city_agency: "N",
 none_of_the_above: "N",
 nonprofit: "Y",
 nourl: "N",
 organizationname: "YWCA of the City of New York",
 other_government_organization: "N",
 outsideloc: "N",
 personal_finance_financial_education: "N",
 phone: "2127554500",
 professional_association: "N",
 published: "Published",
 queens: "N",
 staten_island: "Y",
 url: "http://www.ywcanyc.org",
 veterans_military_families: "N",
 victim_services: "N",
 youth_services: "Y"
 },
 */

//https://data.cityofnewyork.us/api/views/69bm-3bc2/rows.json?accessType=DOWNLOAD
class MetaView {
    var name: String
    var position: Int
    init(dict: [String:Any]) {
        if let name = dict["name"] as? String,
            let position = dict["position"] as? Int {
            self.name = name
            self.position = position
        } else {
            self.name = "error"
            self.position = -2
        }
    }
}

class SocialService {
    var sid: Int?
    var id: String?
    var position: Int?
    var created_at: Int?
    var created_meta: String?
    var updated_at: Int?
    var updated_meta: String?
    var meta: String?
    var organizationname: String = ""
    var brooklyn: String?
    var bronx: String?
    var manhattan: String?
    var queens: String?
    var staten_island: String?
    var fax: Int?
    var phone: Int?
    var url: String?
    var nourl: String?
    var description: String?
    var outsideloc: String?
    var outsidelocdesc: String?
    var aging: String?
    var anti_discrimination_human_rights: String?
    var arts_culture: String?
    var business: String?
    var child_care_parent_information: String?
    var community_service_volunteerism: String?
    var counseling_support_groups: String?
    var disabilities: String?
    var domestic_violence: String?
    var education: String?
    var employment_job_training: String?
    var health: String?
    var homelessness: String?
    var housing: String?
    var immigration: String?
    var legal_services: String?
    var lesbian_gay_bisexual_and_or_transgender: String?
    var personal_finance_financial_education: String?
    var professional_association: String?
    var veterans_military_families: String?
    var victim_services: String?
    var women_s_groups: String?
    var youth_services: String?
    var faith_based_organization: String?
    var foundation: String?
    var is_registered_with_the_attorney_general_s_office: String?
    var new_york_city_agency: String?
    var none_of_the_above: String?
    var nonprofit: String?
    var comments: String?
    var other_government_organization: String?
    var published: String?
    var location: String?
    var location_2: String?
    
    //970
    init(array: [Any]) {
        for (index, item) in array.enumerated() {
            switch index {
            case 0:
                self.sid = item as? Int
            case 1:
                self.id = item as? String
            case 2:
                self.position = item as? Int
            case 3:
                self.created_at = item as? Int
            case 4:
                self.created_meta = item as? String
            case 5:
                self.updated_at = item as? Int
            case 6:
                self.updated_meta = item as? String
            case 7:
                self.meta = item as? String
            case 8:
                self.organizationname = item as! String
            case 9:
                self.brooklyn = item as? String
            case 10:
                self.bronx = item as? String
            case 11:
                self.manhattan = item as? String
            case 12:
                self.queens = item as? String
            case 13:
                self.staten_island = item as? String
            case 14:
                self.fax = item as? Int
            case 15:
                self.phone = item as? Int
            case 16:
                self.url = item as? String
            case 17:
                self.nourl = item as? String
            case 18:
                self.description = item as? String
            case 19:
                self.outsideloc = item as? String
            case 20:
                self.outsidelocdesc = item as? String
            case 21:
                self.aging = item as? String
            case 22:
                self.anti_discrimination_human_rights = item as? String
            case 23:
                self.arts_culture = item as? String
            case 24:
                self.business = item as? String
            case 25:
                self.child_care_parent_information = item as? String
            case 26:
                self.community_service_volunteerism = item as? String
            case 27:
                self.counseling_support_groups = item as? String
            case 28:
                self.disabilities = item as? String
            case 29:
                self.domestic_violence = item as? String
            case 30:
                self.education = item as? String
            case 31:
                self.employment_job_training = item as? String
            case 32:
                self.health = item as? String
            case 33:
                self.homelessness = item as? String
            case 34:
                self.housing = item as? String
            case 35:
                self.immigration = item as? String
            case 36:
                self.legal_services = item as? String
            case 37:
                self.lesbian_gay_bisexual_and_or_transgender = item as? String
            case 38:
                self.personal_finance_financial_education = item as? String
            case 39:
                self.professional_association = item as? String
            case 40:
                self.veterans_military_families = item as? String
            case 41:
                self.victim_services = item as? String
            case 42:
                self.women_s_groups = item as? String
            case 43:
                self.youth_services = item as? String
            case 44:
                self.faith_based_organization = item as? String
            case 45:
                self.foundation = item as? String
            case 46:
                self.is_registered_with_the_attorney_general_s_office = item as? String
            case 47:
                self.new_york_city_agency = item as? String
            case 48:
                self.none_of_the_above = item as? String
            case 49:
                self.nonprofit = item as? String
            case 50:
                self.comments = item as? String
            case 51:
                self.other_government_organization = item as? String
            case 52:
                self.published = item as? String
            case 53:
                self.location = item as? String
            case 54:
                self.location_2 = item as? String
            default:
                break
            }
        }
    }
}

