//
//  ContactsService.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol ContactsServiceProtocol: class {
    func fetchConverter(_ completion: @escaping ((Result<[ContactsModel], ErrorResult>) -> Void))
}

final class ContactsService: RequestHandler, ContactsServiceProtocol {

    let endpoint = "https://gist.githubusercontent.com/pokeytc/e8c52af014cf80bc1b217103bbe7e9e4/raw/4bc01478836ad7f1fb840f5e5a3c24ea654422f7/contacts.json"
    var task: URLSessionTask?
    func fetchConverter(_ completion: @escaping ((Result<[ContactsModel], ErrorResult>) -> Void)) {
        self.cancelFetchCurrencies()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetchCurrencies() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
