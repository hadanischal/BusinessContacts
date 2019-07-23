//
//  ContactsViewModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class ContactsViewModel: ContactsViewModelProtocol {

    private var dataSource: GenericDataSource<ContactsModel>?
    private var service: ContactsServiceProtocol?

    private var contacts: [ContactsModel] = [ContactsModel]()

    init(service: ContactsServiceProtocol = ContactsService(), dataSource: GenericDataSource<ContactsModel>?) {
        self.dataSource = dataSource
        self.service = service
    }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {

        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchContacts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self?.contacts = converter
                    self?.contacts.sort(by: ContactsModel.Comparison.firstLastAscending)
                    self?.dataSource?.data.value = self?.contacts ?? []
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

    func didSelectSegment(_ segmentIndex: Int) {
        if segmentIndex == 0 {
            self.dataSource?.data.value = self.contacts
        } else {
            self.dataSource?.data.value = filteredArray
        }
    }
    
    private var filteredArray: [ContactsModel] {
       //mocking favorite,
        self.contacts[1].isFavorite = true
        let filteredlist = self.contacts.filter { $0.isFavorite == true }
        return filteredlist
    }
}
