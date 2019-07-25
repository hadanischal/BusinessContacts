//
//  MockContactsService.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 7/25/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import BusinessContacts

class MockContactsService: ContactsServiceProtocol {
    var fetchedContacts: [ContactsModel]?

    func fetchContacts(_ completion: @escaping ((Result<[ContactsModel], ErrorResult>) -> Void)) {
        if let contact = fetchedContacts {
            completion(.success(contact))
        } else {
            completion(.failure(ErrorResult.custom(string: "unable to filter response")))
        }
    }
}
