//
//  ParserHelper.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(data: Data) -> Result<[Self], ErrorResult>
}

final class ParserHelper {
    static func parse<T: Parceable>(data: Data, completion: (Result<[T], ErrorResult>) -> Void) {
        switch T.parseObject(data: data) {
        case .failure(let error):
            completion(.failure(error))
            break
        case .success(let newModel):
            completion(.success(newModel))
            break
        }
    }
}
