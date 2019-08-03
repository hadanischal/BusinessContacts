//
//  ContactsViewController.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    private let itemsPerRowPortrait: CGFloat = 1
    private let itemsPerRowLandscape: CGFloat = 2
    private let segmentedInsets = UIEdgeInsets(top: 0.0, left: 50.0, bottom: 5.0, right: 10.0)

    var currentInterfaceOrientation: UIInterfaceOrientation = UIInterfaceOrientation.unknown

    private let refreshControl = UIRefreshControl()
    @IBOutlet var collectionView: UICollectionView!

    let dataSource = ContactsDataSource()
    private var viewModel: ContactsViewModelProtocol?
    @IBOutlet weak var showMoreButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionViewSetUp()
        self.collectionView.dataSource = self.dataSource

        self.viewModel = ContactsViewModel(dataSource: dataSource)
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
            self?.showMoreButton.isHidden = true
        }
        self.setupUIRefreshControl()
        self.setupUISegmentedControl()
        self.serviceCall()
        self.showMoreButton.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currentInterfaceOrientation = UIApplication.shared.statusBarOrientation
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.currentInterfaceOrientation = UIInterfaceOrientation.landscapeLeft
            } else {
                self.currentInterfaceOrientation = UIInterfaceOrientation.portrait
            }
            self.deviceDidRotate()
        })
    }

    func deviceDidRotate() {
        self.collectionView.reloadData()
        self.setupUISegmentedControl()
    }

    func setupUIRefreshControl() {
        refreshControl.addTarget(self, action: #selector(serviceCall), for: UIControl.Event.valueChanged)
        self.collectionView.addSubview(refreshControl)
    }

    func setupUISegmentedControl() {
        let paddingSpace = segmentedInsets.left * 2
        let availableWidth = view.frame.width - paddingSpace

        let items = ["All", "Favourites"]
        let segmentedController = UISegmentedControl(items: items)
        segmentedController.frame =  CGRect(x: segmentedInsets.left, y: segmentedInsets.top, width: availableWidth, height: segmentedController.frame.height)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        navigationItem.titleView = segmentedController
    }

    @objc func serviceCall() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.viewModel?.fetchServiceCall { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        refreshControl.endRefreshing()
    }

    @objc func didSelectSegment(_ sender: UISegmentedControl) {
        let contactType = ContactType(rawValue: sender.selectedSegmentIndex)
        viewModel?.didSelectSegment(withContactType: contactType)
    }

    // MARK: Button Action
    @IBAction func actionShowMore(_ sender: UIButton) {
        self.viewModel?.showMoreContactList()
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ContactsViewController: UICollectionViewDelegateFlowLayout {

    func CollectionViewSetUp() {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //0.0
        self.collectionView.backgroundColor = ThemeColor.collectionViewBackgroundColor
        self.collectionView.showsHorizontalScrollIndicator = false
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemsPerRow = itemsPerRowPortrait
        if self.currentInterfaceOrientation == .portrait ||  self.currentInterfaceOrientation == .portraitUpsideDown {
            itemsPerRow = itemsPerRowPortrait
        } else {
            itemsPerRow = itemsPerRowLandscape
        }
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = CGFloat(200.00)

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension ContactsViewController {

    // MARK: - Lazy Loading of cells
    func loadImagesForOnscreenRows() {
//        self.collectionView.reloadData()
        self.showMoreButton.isHidden = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }

}
