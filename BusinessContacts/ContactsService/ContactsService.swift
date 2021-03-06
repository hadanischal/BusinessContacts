//
//  ContactsService.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class ContactsService: RequestHandler, ContactsServiceProtocol {
    override init() {
    }
    let endpoint = "https://gist.githubusercontent.com/hadanischal/db18a2029d898600cc8e5c4604478750/raw/2d746828c92165919930613839961d0b3ee61d7a/contacts.json"

    var task: URLSessionTask?
    func fetchContacts(_ completion: @escaping ((Result<[ContactsModel], ErrorResult>) -> Void)) {
        self.cancelFetchContacts()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetchContacts() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
