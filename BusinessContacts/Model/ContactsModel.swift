//
//  ContactsModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

var util: Util { return Util() }

struct ContactsModel {
    let first_name: String!
    let last_name: String!
    let email: String!
    let gender: String!
    let id: AnyObject!
    
    init(dictionary: [String: Any]) {
        self.first_name = util.filterNil(dictionary["first_name"] as AnyObject) as! String
        self.last_name = util.filterNil(dictionary["last_name"] as AnyObject) as! String
        self.email = util.filterNil(dictionary["email"] as AnyObject) as! String
        self.gender = util.filterNil(dictionary["gender"] as AnyObject) as! String
        self.id = util.filterNil(dictionary["id"] as AnyObject)
    }
    
}

extension ContactsModel : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<ContactsModel, ErrorResult>{
        if (dictionary["first_name"] as? String) != nil{
            let object = ContactsModel(dictionary: dictionary)
            return Result.success(object)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
    
    
    
}
