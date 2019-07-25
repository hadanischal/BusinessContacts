//
//  ContactsServiceProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/25/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol ContactsServiceProtocol {
    func fetchContacts(_ completion: @escaping ((Result<[ContactsModel], ErrorResult>) -> Void))
}
