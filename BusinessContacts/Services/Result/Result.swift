//
//  Result.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
