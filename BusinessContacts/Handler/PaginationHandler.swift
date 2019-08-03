//
//  PaginationHandler.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/28/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class PaginationHandler: PaginationHandlerProtocol {
    private let pageSize = Config.pageSize

    static let defaultModel: PaginationModel =  PaginationModel(pageNo: 0, nextPage: 0, hasMore: false, isLoading: false, pageSize: Config.pageSize, totalCount: 0)
    private var model: PaginationModel!

    init(withModel model: PaginationModel = defaultModel ) {
        self.model = model
    }

    func savePagination(withContact contactList: [ContactsModel]) {
        if contactList.count > 0 {
            let hasMore: Bool = contactList.count > pageSize

            let pagination = PaginationModel(pageNo: 0,
                                             nextPage: hasMore ? 1 : 0,
                                             hasMore: hasMore,
                                             isLoading: false,
                                             pageSize: pageSize,
                                             totalCount: contactList.count)
            self.model = pagination
         }
    }

    func getContactWithPagination( withContact contactList: [ContactsModel], completion: @escaping ([ContactsModel]) -> Void) {

        let page = model.pageNo
        let numberOfItemsPerPage = model.pageSize
        let data = contactList

        DispatchQueue.main.async {
            let firstIndex = page * numberOfItemsPerPage
            guard firstIndex < data.count else {
                completion([])
                return
            }
            let lastIndex = (page + 1) * numberOfItemsPerPage < data.count ?
                (page + 1) * numberOfItemsPerPage : data.count
            let selectedData = Array(data[firstIndex ..< lastIndex])
            completion(selectedData)
        }
    }

    func updatePagination() {

        let hasMore: Bool = model.nextPage * model.pageSize < model.totalCount

        let pagination = PaginationModel(pageNo: model.nextPage,
                                         nextPage: hasMore ? model.nextPage + 1 : model.nextPage,
                                         hasMore: hasMore,
                                         isLoading: false,
                                         pageSize: pageSize,
                                         totalCount: model.totalCount)
        self.model = pagination
     }
}
