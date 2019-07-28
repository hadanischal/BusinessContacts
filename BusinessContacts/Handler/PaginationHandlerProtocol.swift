//
//  PaginationHandlerProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/28/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol PaginationHandlerProtocol {
    var currentContact: Dynamic<[ContactsModel]> { get }
    var model: PaginationModel? { get }

    func savePageCount(withContact contactList: [ContactsModel])
    func loadData(_ onComplete: @escaping ([ContactsModel]) -> Void)
}
