//
//  MockPaginationHandler.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 7/30/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import BusinessContacts

class MockPaginationHandler: PaginationHandlerProtocol {
    var fetchedContacts: [ContactsModel] = [ContactsModel]()

    func savePagination(withContact contactList: [ContactsModel]) {

    }

    func getContactWithPagination(withContact contactList: [ContactsModel], completion: @escaping ([ContactsModel]) -> Void) {
        if contactList.count > 0 {
            fetchedContacts = contactList
        }
        completion(fetchedContacts)
    }

    func updatePagination() {

    }
}
