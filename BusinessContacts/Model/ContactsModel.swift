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

    func fullname() -> String {
        return self.first_name + " " + self.last_name
    }

}

extension ContactsModel: Parceable {

    static func parseObject(dictionary: [String: AnyObject]) -> Result<ContactsModel, ErrorResult> {
        if (dictionary["first_name"] as? String) != nil {
            let object = ContactsModel(dictionary: dictionary)
            return Result.success(object)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }

}

extension ContactsModel: Comparable {

    static func == (lhs: ContactsModel, rhs: ContactsModel) -> Bool {
        return (lhs.first_name, lhs.last_name) ==
            (rhs.first_name, rhs.last_name)
    }

    static func < (lhs: ContactsModel, rhs: ContactsModel) -> Bool {
        return (lhs.last_name, lhs.first_name) <
            (rhs.last_name, rhs.first_name)
    }
}

extension ContactsModel {
    enum Comparison {
        static let firstLastAscending: (ContactsModel, ContactsModel) -> Bool = {
            return ($0.first_name, $0.last_name) <
                ($1.first_name, $1.last_name)
        }
    }
}
//contacts.sort(by: Contact.Comparison.firstLastAscending)
