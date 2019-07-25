//
//  ContactsServiceTests.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 5/31/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import BusinessContacts

class ContactsServiceTests: XCTestCase {
    var testService: ContactsService!
    
    override func setUp() {
        super.setUp()
        self.testService = ContactsService()
    }
    
    override func tearDown() {
        self.testService = nil
        super.tearDown()
    }
    
    func testCancelRequest() {
        testService.fetchContacts { (_) in
        }
        testService.cancelFetchContacts()
        XCTAssertNil( self.testService.task, "Expected task nil")
    }
}
