//
//  DispatcheBaseModel.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 3/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class DispatcheBaseModel {
    let queue: DispatchQueue
    init(queue: DispatchQueue) {
        self.queue = queue
    }
}
