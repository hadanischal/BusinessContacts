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
                print(result)
                //                switch result {
                //                case .success(let converter) :
                //                    self.dataSource?.data.value = converter.rows
                //                    self.title = converter.title
                //                    completion?(Result.success(true))
                //                    break
                //                case .failure(let error) :
                //                    print("Parser error \(error)")
                //                    completion?(Result.failure(error))
                //                    break
                //                }
            }
        }
    }
    
}


