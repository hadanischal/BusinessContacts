//
//  PaginationHandler.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/28/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class PaginationHandler: PaginationHandlerProtocol {
    var model: PaginationModel?
    var contactList: [ContactsModel]?
    let currentContact: Dynamic<[ContactsModel]>

    init() {
        self.model = PaginationModel(pageNo: 0, nextPage: 1, hasMore: true, isLoading: false, pageSize: 20, totalCount: 20)
        currentContact = Dynamic([])
    }

    func savePageCount(withContact contactList: [ContactsModel]) {
        self.contactList = contactList
        if let _ = model {
            let hasMore: Bool = contactList.count > 20

            let pagination = PaginationModel(pageNo: 0,
                                             nextPage: hasMore ? 1 : 0,
                                             hasMore: hasMore,
                                             isLoading: false,
                                             pageSize: 20,
                                             totalCount: contactList.count)
            self.model = pagination
        }
    }

    private func updatePageCount() {
        if let currentPage = model {
            let hasMore: Bool = currentPage.nextPage * currentPage.pageSize < currentPage.totalCount

            let pagination = PaginationModel(pageNo: currentPage.nextPage,
                                             nextPage: hasMore ? currentPage.nextPage + 1 : currentPage.nextPage,
                                             hasMore: hasMore,
                                             isLoading: false,
                                             pageSize: 20,
                                             totalCount: currentPage.totalCount)
            self.model = pagination
        }
    }

    func loadData(_ onComplete: @escaping ([ContactsModel]) -> Void) {
        guard
            let model = model,
            let contactList = contactList else {
                onComplete([])
                return
        }

        let page = model.pageNo
        let numberOfItemsPerPage = model.pageSize
        let data = contactList

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let firstIndex = page * numberOfItemsPerPage
            guard firstIndex < data.count else {
                onComplete([])
                return
            }
            let lastIndex = (page + 1) * numberOfItemsPerPage < data.count ?
                (page + 1) * numberOfItemsPerPage : data.count
            let selectedData = Array(data[firstIndex ..< lastIndex])
            self.currentContact.value = selectedData
            self.updatePageCount()
            onComplete(Array(data[firstIndex ..< lastIndex]))
        }
    }
}
