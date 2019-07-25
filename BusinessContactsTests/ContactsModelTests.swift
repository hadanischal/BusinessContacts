//
//  ContactsModelTests.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 5/31/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import BusinessContacts

class ContactsModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExampleEmptyData() {
        let data = Data()
        let completion: ((Result<[ContactsModel], ErrorResult>) -> Void) = { result in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testParseValidData() {
        let data = MockData().stubContactData()
        let completion: ((Result<[ContactsModel], ErrorResult>) -> Void) = { result in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid converter")
            case .success(let list):
                XCTAssertNotNil(list, "expect dataSource data value be not nil")
                XCTAssertEqual(list.count, 100, "Expected result count to be 1")
                
                let contactValue = list[0]
                XCTAssertNotNil(contactValue, "expect contactValue be not nil")
                XCTAssertEqual(contactValue.email, "bwright0@go.com", "Expected email to be abennett1h@hubpages.com")
                XCTAssertEqual(contactValue.first_name, "Bonnie", "Expected first name to be Alan")
            }
        }
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testInvalidData() {
        let result = ContactsModel.parseObject(data: MockData().stubDummyWrongData())
        switch result {
        case .success:
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
    
}
