//
//  ContactsViewModelTests.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 5/31/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import BusinessContacts

class ContactsViewModelTests: XCTestCase {
    var viewModel: ContactsViewModel!
    private var mockDataSource: GenericDataSource<ContactsModel>!
    private var mockService: MockContactsService!
    
    override func setUp() {
        super.setUp()
        self.mockService = MockContactsService()
        self.mockDataSource = GenericDataSource<ContactsModel>()
        self.viewModel = ContactsViewModel(service: mockService, dataSource: mockDataSource)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockService = nil
        self.mockDataSource = nil
        super.tearDown()
    }
    
    func testFetchNoServiceCall() {
        mockService.fetchedContacts = nil
        viewModel.fetchServiceCall { result in
            switch result {
            case .success :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default: break
            }
        }
    }
    
    func testFetchServiceCall() {
        mockService.fetchedContacts = MockData().stubContactList()
        viewModel.fetchServiceCall { result in
            switch result {
            case .success(let status):
                XCTAssertTrue(status, "expect status to be true")
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
    }
    
    func testFetchAllContacts() {
        let exp = expectation(description: "Loading service call")
        
        mockService.fetchedContacts = MockData().stubContactList()
        viewModel.fetchServiceCall { result in
            exp.fulfill()
            switch result {
            case .success(let status):
                let list = self.mockDataSource.data.value
                XCTAssertTrue(status, "expect status to be true")
                XCTAssertNotNil(list, "expect dataSource data value be not nil")
                XCTAssertEqual(list.count, 100, "Expected result count to be 1")
                
                let contactValue = list[0]
                XCTAssertNotNil(contactValue, "expect contactValue be not nil")
                XCTAssertEqual(contactValue.email, "abennett1h@hubpages.com", "Expected email to be abennett1h@hubpages.com")
                XCTAssertEqual(contactValue.first_name, "Alan", "Expected first name to be Alan")
                break
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
        waitForExpectations(timeout: 3)
        
        viewModel.didSelectSegment(0) //Select all contact
        let list = self.mockDataSource.data.value
        XCTAssertNotNil(list, "expect dataSource data value be not nil")
        XCTAssertEqual(list.count, 100, "Expected result count to be 1")
        
        let contactValue = list[0]
        XCTAssertNotNil(contactValue, "expect contactValue be not nil")
        XCTAssertEqual(contactValue.email, "abennett1h@hubpages.com", "Expected email to be abennett1h@hubpages.com")
        XCTAssertEqual(contactValue.first_name, "Alan", "Expected first name to be Alan")
        
    }
    
    func testFavouritesContacts() {
        // create the expectation
        let exp = expectation(description: "Loading service call")
        mockService.fetchedContacts = MockData().stubContactListWithFavorite()
        viewModel.fetchServiceCall { result in
            exp.fulfill()
            switch result {
            case .success(let status):
                let list = self.mockDataSource.data.value
                XCTAssertTrue(status, "expect status to be true")
                XCTAssertNotNil(list, "expect dataSource data value be not nil")
                XCTAssertEqual(list.count, 100, "Expected result count to be 1")
                
                break
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
        waitForExpectations(timeout: 3)
        viewModel.didSelectSegment(1)
        
        let list = self.mockDataSource.data.value
        XCTAssertNotNil(list, "expect dataSource data value be not nil")
        XCTAssertEqual(list.count, 16, "Expected result count to be 1")
        
        let contactValue = list[0]
        XCTAssertNotNil(contactValue, "expect contactValue be not nil")
        XCTAssertEqual(contactValue.email, "akelleym@shinystat.com", "Expected email to be abennett1h@hubpages.com")
        XCTAssertEqual(contactValue.first_name, "Ashley", "Expected first name to be Alan")
        XCTAssertEqual(contactValue.isFavorite, true, "Expected isFavorite to be true")
        
    }
    
    func testUpdateFavoriteContact() {
        let exp = expectation(description: "Loading service call")
        let list = MockData().stubContactList()
        
        let randomIndex = Int.random(in: 0 ..< 10) //select random index
        let randomContact = list[randomIndex] // selct random contact
        
        mockService.fetchedContacts = list
        viewModel.fetchServiceCall { result in
            exp.fulfill()
            switch result {
            case .success(let status):
                XCTAssertTrue(status, "expect status to be true")
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
        waitForExpectations(timeout: 3)
        viewModel.updateContact(randomContact)
        viewModel.didSelectSegment(1)

        let dataSourceValue = self.mockDataSource.data.value
        XCTAssertNotNil(dataSourceValue, "expect dataSource data value be not nil")
        XCTAssertEqual(dataSourceValue.count, 1, "Expected result count to be 1")
        
        let updatedValue = dataSourceValue[0]
        XCTAssertNotNil(updatedValue, "expect contactValue be not nil")
        XCTAssertEqual(updatedValue.email, randomContact.email, "Expected email to be abennett1h@hubpages.com")
        XCTAssertEqual(updatedValue.first_name, randomContact.first_name, "Expected first name to be Alan")
        XCTAssertEqual(updatedValue.isFavorite, true, "Expected isFavorite to be true")
    }
    
    
}
