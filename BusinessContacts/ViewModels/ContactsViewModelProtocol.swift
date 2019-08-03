//
//  ContactsViewModelProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/16/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol ContactsViewModelProtocol {
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)?)
    func didSelectSegment(withContactType contactType: ContactType?)
    func showMoreContactList()
}
