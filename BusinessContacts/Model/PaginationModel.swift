//
//  PaginationModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/28/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct PaginationModel {
    /// Last page fetched.  Start at 0, fetch calls use page+1 and increment after.  Read-Only
    var pageNo: Int

    var nextPage: Int //offSet, pageNo*perPage

    var hasMore: Bool
    var isLoading: Bool

    /// Size of pages.
    var pageSize: Int //20

    /// Total number of results
    var totalCount: Int

}
