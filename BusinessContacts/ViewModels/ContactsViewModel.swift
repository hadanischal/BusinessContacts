//
//  ContactsViewModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class ContactsViewModel {
    weak var dataSource : GenericDataSource<ContactsModel>?
    weak var service: ContactsServiceProtocol?
    
    init(service: ContactsServiceProtocol, dataSource : GenericDataSource<ContactsModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    var contacts = converter
                    contacts.sort(by: ContactsModel.Comparison.firstLastAscending)
                    self.dataSource?.data.value = contacts
                    completion?(Result.success(true))
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }
    
}

 

