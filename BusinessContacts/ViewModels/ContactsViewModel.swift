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

    //input
    private var dataSource: GenericDataSource<ContactsModel>?
    private var service: ContactsServiceProtocol?
    private var paginationHandler: PaginationHandlerProtocol!
    private var dispatchQueueHelper: DispatchProtocol!

    private var contacts: [ContactsModel] = [ContactsModel]()
    private var selectedSegment: ContactType = ContactType.all
    private var paginatedContacts: [ContactsModel] = [ContactsModel]()

    init(service: ContactsServiceProtocol = ContactsService(),
         dataSource: GenericDataSource<ContactsModel>?,
         withPaginationHandler paginationHandler: PaginationHandlerProtocol = PaginationHandler(),
         withDispatchQueueHelper dispatchQueueHelper: DispatchProtocol = AsyncQueue.main
        ) {
        self.dataSource = dataSource
        self.service = service
        self.paginationHandler = paginationHandler
        self.dataSource?.delegate = self //delegate to receive Favorite contact list
        self.dispatchQueueHelper = dispatchQueueHelper
    }

    // MARK: API request

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {

        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchContacts { [weak self] result in
            self?.dispatchQueueHelper.dispatch {
                switch result {
                case .success(let list) :
                    self?.contacts = list
                    self?.contacts.sort(by: ContactsModel.Comparison.firstLastAscending)
                    
                    self?.handellServerResponse()
                    //self?.dataSource?.data.value = contactList
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

    // MARK: Handell pagination of contact List
    private func handellServerResponse() {
        self.paginationHandler.savePagination(withContact: contacts) //first save pagination info
        self.getContactWithPagination() // get paginated contact depending on pagination info
    }

    func showMoreContactList() {
        self.getContactWithPagination()
    }

    private func getContactWithPagination() {
        self.paginationHandler.getContactWithPagination(withContact: contacts) { [weak self] paginatedContactList in
                self?.paginatedContacts = paginatedContactList
                self?.didSelectSegment(withContactType: nil)
        }
    }

    // MARK: UISegmentedControl action

    func didSelectSegment(withContactType contactType: ContactType?) {
        //set contact type if its been passed if else dont
        if let type = contactType {
            selectedSegment = type
        }

        switch selectedSegment {
        case .all:
            self.dataSource?.data.value = self.paginatedContacts // self.contacts

        case .favourites:
            self.dataSource?.data.value = favoriteList
        }
    }

    // MARK: Update Favorite contact List
    private var favoriteList: [ContactsModel] {
        ///let filteredlist = self.contacts.filter { $0.isFavorite == true }
        let filteredlist = self.paginatedContacts.filter { $0.isFavorite == true }
        return filteredlist
    }

    private func saveUpdatedContact(withContact data: ContactsModel) {
        let isFavorite: Bool = data.isFavorite ?? false
        ///self.contacts.filter({$0.id == data.id}).first?.isFavorite = true

        if let row = self.paginatedContacts.firstIndex(where: {$0.id == data.id}) {
            self.paginatedContacts[row].isFavorite = !isFavorite
            self.didSelectSegment(withContactType: nil)
        }

        if let row = self.contacts.firstIndex(where: {$0.id == data.id}) {
            self.contacts[row].isFavorite = !isFavorite
        }
    }
}
