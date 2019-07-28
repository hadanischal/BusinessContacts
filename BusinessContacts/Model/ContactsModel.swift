//
//  ContactsModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct ContactsModel: Codable {
    let first_name: String
    let last_name: String
    let email: String
    let gender: Gender
    let id: Int

    var isFavorite: Bool? = false
}

extension ContactsModel: Parceable {
    static func parseObject(data: Data) -> Result<[ContactsModel], ErrorResult> {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode([ContactsModel].self, from: data) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse ContactsModel results"))
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
