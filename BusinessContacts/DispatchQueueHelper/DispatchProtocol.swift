//
//  DispatchProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 3/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol DispatchProtocol {
    func dispatch(_ work: @escaping () -> Void)
}
