//
//  ContactsDataSourceTests.swift
//  BusinessContactsTests
//
//  Created by Nischal Hada on 5/31/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import BusinessContacts

class ContactsDataSourceTests: XCTestCase {
    var dataSource: ContactsDataSource!

    override func setUp() {
        super.setUp()
        dataSource = ContactsDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        dataSource?.data.value = []
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        XCTAssertEqual(dataSource?.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
        XCTAssertEqual(dataSource?.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
    }

    func testValueInDataSource() {
        let responseResults = MockData().stubContactList()
        dataSource?.data.value = responseResults
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        XCTAssertEqual(dataSource?.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource?.collectionView(collectionView, numberOfItemsInSection: 0), responseResults.count, "Expected numberOfItemsInSection equal responseResults count")
    }
}
