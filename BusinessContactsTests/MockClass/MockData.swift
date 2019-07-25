//
//  MockData.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 7/25/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import BusinessContacts

class MockData {
    func stubContactData() -> Data {
        guard let data = self.readJson(forResource: "contacts") else {
            XCTAssert(false, "Can't get data from contacts.json")
            return Data()
        }
        return data
    }
    
    func stubDummyWrongData() -> Data {
        guard let data = self.readJson(forResource: "dummyWrong") else {
            XCTAssert(false, "Can't get data from dummyWrong.json")
            return Data()
        }
        return data
    }
    
    func stubContactList() -> [ContactsModel] {
        guard let data = self.readJson(forResource: "contacts") else {
            XCTAssert(false, "Can't get data from contacts.json")
            return [ContactsModel.empty]
        }
        
        let decoder = JSONDecoder()
        if let result = try? decoder.decode([ContactsModel].self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse CityListModel results")
            return [ContactsModel.empty]
        }
    }
    
    func stubContactListWithFavorite() -> [ContactsModel] {
        var result = self.stubContactList()
        for index in 20...35 {
            result[index].isFavorite = true
        }
        return result
    }
    
}


extension MockData {
    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTFail("unable to read json")
            return nil
        }
    }
}

extension ContactsModel {
    static var empty: ContactsModel {
        return ContactsModel(first_name: "", last_name: "", email: "", gender: .female, id: 0, isFavorite: false)
    }
}
