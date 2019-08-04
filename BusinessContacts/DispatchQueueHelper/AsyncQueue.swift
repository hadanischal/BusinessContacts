//
//  AsyncQueue.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 3/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class AsyncQueue: DispatcheBaseModel, DispatchProtocol {
    static let main: AsyncQueue = AsyncQueue(queue: .main)
    static let global: AsyncQueue = AsyncQueue(queue: .global())
    static let background: AsyncQueue = AsyncQueue(queue: .global(qos: .background))

    func dispatch(_ work: @escaping () -> Void) {
        queue.async(execute: work)
    }
}
