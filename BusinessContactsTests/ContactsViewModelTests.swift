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
    private var mockPaginationHandler: MockPaginationHandler!
    private var mockDispatchQueueHelper: DispatchProtocol!

    override func setUp() {
        super.setUp()
        self.mockService = MockContactsService()
        self.mockDataSource = GenericDataSource<ContactsModel>()
        self.mockPaginationHandler = MockPaginationHandler()
        self.mockDispatchQueueHelper = SyncQueue.stubbedMain
        self.viewModel = ContactsViewModel(service: mockService, dataSource: mockDataSource, withPaginationHandler: mockPaginationHandler, withDispatchQueueHelper: self.mockDispatchQueueHelper)
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
        let stubData = MockData().stubContactList()
        mockService.fetchedContacts = stubData
        mockPaginationHandler.fetchedContacts = stubData

        viewModel.fetchServiceCall { result in
            switch result {
            case .success(let status):
                let list = self.mockDataSource.data.value
                XCTAssertTrue(status, "expect status to be true")
                XCTAssertNotNil(list, "expect dataSource data value be not nil")

                if list.count > 0 {
                    XCTAssertEqual(list.count, 100, "Expected result count to be 1")

                    let contactValue = list[0]
                    XCTAssertNotNil(contactValue, "expect contactValue be not nil")
                    XCTAssertEqual(contactValue.email, "abennett1h@hubpages.com", "Expected email to be abennett1h@hubpages.com")
                    XCTAssertEqual(contactValue.first_name, "Alan", "Expected first name to be Alan")
                } else {
                    XCTAssert(false, "expected list count to be > 0 got \(list.count)")
                }
                break
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
    }

    func testSelectAllSegmentAction() {
        //Mock data source
        self.mockFetchConatctListFromServer()

        //Implement test for segment action
        viewModel.didSelectSegment(withContactType: .all)
        let list = self.mockDataSource.data.value
        XCTAssertNotNil(list, "expect dataSource data value be not nil")
        XCTAssertEqual(list.count, 100, "Expected result count to be 1")
        if list.count > 0 {
            let contactValue = list[0]
            XCTAssertNotNil(contactValue, "expect contactValue be not nil")
            XCTAssertEqual(contactValue.email, "abennett1h@hubpages.com", "Expected email to be abennett1h@hubpages.com")
            XCTAssertEqual(contactValue.first_name, "Alan", "Expected first name to be Alan")
        } else {
            XCTAssert(false, "expected list count to be > 0 got \(list.count)")
        }

    }

    func testSelectFavouritesSegmentAction() {
        //Mock data source
        self.mockFavouriteConatctList()

        //Implement test favourite contact
        viewModel.didSelectSegment(withContactType: .favourites)

        let list = self.mockDataSource.data.value
        XCTAssertNotNil(list, "expect dataSource data value be not nil")
        XCTAssertEqual(list.count, 16, "Expected result count to be 1")

        if list.count > 0 {
            let contactValue = list[0]
            XCTAssertNotNil(contactValue, "expect contactValue be not nil")
            XCTAssertEqual(contactValue.email, "akelleym@shinystat.com", "Expected email to be abennett1h@hubpages.com")
            XCTAssertEqual(contactValue.first_name, "Ashley", "Expected first name to be Alan")
            XCTAssertEqual(contactValue.isFavorite, true, "Expected isFavorite to be true")
        } else {
            XCTAssert(false, "expected list count to be > 0 got \(list.count)")
        }

    }

    func testUpdateFavoriteContact() {

        //Mock data source
        self.mockFetchConatctListFromServer()

        //Implement test for update favourite contact
        let list = MockData().stubContactList()
        let randomIndex = Int.random(in: 0 ..< 10) //select random index
        let randomContact = list[randomIndex] // selct random contact

        viewModel.updateContact(randomContact)
        viewModel.didSelectSegment(withContactType: .favourites)

        let dataSourceValue = self.mockDataSource.data.value
        XCTAssertNotNil(dataSourceValue, "expect dataSource data value be not nil")
        XCTAssertEqual(dataSourceValue.count, 1, "Expected result count to be 1")

        if dataSourceValue.count > 0 {
            let updatedValue = dataSourceValue[0]
            XCTAssertNotNil(updatedValue, "expect contactValue be not nil")
            XCTAssertEqual(updatedValue.email, randomContact.email, "Expected email to be abennett1h@hubpages.com")
            XCTAssertEqual(updatedValue.first_name, randomContact.first_name, "Expected first name to be Alan")
            XCTAssertEqual(updatedValue.isFavorite, true, "Expected isFavorite to be true")
        } else {
            XCTAssert(false, "expected dataSourceValue count to be > 0 got \(dataSourceValue.count)")
        }
    }

    // MARK: Mock data

    func mockFetchConatctListFromServer() {
        let stubData = MockData().stubContactList()
        mockService.fetchedContacts = stubData
        mockPaginationHandler.fetchedContacts = stubData

        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            case .success:
                XCTAssertTrue(true, "expect status to be true")
            }
        }
    }

    func mockFavouriteConatctList() {
        let stubData = MockData().stubContactListWithFavorite()
        mockService.fetchedContacts = stubData
        mockPaginationHandler.fetchedContacts = stubData

        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            case .success:
                XCTAssertTrue(true, "expect status to be true")
            }
        }
    }

}

extension SyncQueue {
    static let stubbedMain: SyncQueue = SyncQueue(queue: DispatchQueue(label: "stubbed-main-queue"))
}
