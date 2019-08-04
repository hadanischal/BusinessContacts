//
//  SyncQueue.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 3/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class SyncQueue: DispatcheBaseModel, DispatchProtocol {
    static let main: SyncQueue = SyncQueue(queue: .main)
    static let global: SyncQueue = SyncQueue(queue: .global())
    static let background: SyncQueue = SyncQueue(queue: .global(qos: .background))

    func dispatch(_ work: @escaping () -> Void) {
        queue.sync(execute: work)
    }
}
