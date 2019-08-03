//
//  PaginationHandlerProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/28/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol PaginationHandlerProtocol {
    func savePagination(withContact contactList: [ContactsModel])
    func getContactWithPagination( withContact contactList: [ContactsModel], completion: @escaping ([ContactsModel]) -> Void)
    func updatePagination()
}
