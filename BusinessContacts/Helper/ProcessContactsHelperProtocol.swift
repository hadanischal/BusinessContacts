//
//  ProcessContactsHelperProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/17/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol ProcessContactsHelperProtocol {
    func filterListByFavorite(withCharacterList list: [ContactsModel], completion: @escaping ((Result<[ContactsModel], ErrorResult>) -> Void))
}
