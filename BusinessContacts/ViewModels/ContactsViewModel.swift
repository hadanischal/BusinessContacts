//
//  ContactsViewModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class ContactsViewModel: ContactsViewModelProtocol, UpdateContactDelegate {
    func updateContact(_ data: ContactsModel) {
        print("data", data.first_name, data.email)
        self.saveUpdatedContact(withContact: data)
    }

    private var dataSource: GenericDataSource<ContactsModel>?
    private var service: ContactsServiceProtocol?

    private var contacts: [ContactsModel] = [ContactsModel]()
    private var selectedSegment:Int? = 0
    
    init(service: ContactsServiceProtocol = ContactsService(), dataSource: GenericDataSource<ContactsModel>?) {
        self.dataSource = dataSource
        self.service = service
        self.dataSource?.delegate = self
    }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {

        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchContacts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list) :
                    self?.contacts = list
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
        selectedSegment = segmentIndex
        if segmentIndex == 0 {
            self.dataSource?.data.value = self.contacts
        } else {
            self.dataSource?.data.value = filteredArray
        }
    }
    
    private var filteredArray: [ContactsModel] {
        let filteredlist = self.contacts.filter { $0.isFavorite == true }
        return filteredlist
    }
    
    private func saveUpdatedContact(withContact data: ContactsModel) {
        let isFavorite:Bool = data.isFavorite ?? false
//        self.contacts.filter({$0.id == data.id}).first?.isFavorite = true
        if let row = self.contacts.firstIndex(where: {$0.id == data.id}) {
            self.contacts[row].isFavorite = !isFavorite
            self.didSelectSegment(selectedSegment ?? 0)
        }
    }
}
