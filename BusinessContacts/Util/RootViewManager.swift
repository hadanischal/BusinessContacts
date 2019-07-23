//
//  RootViewManager.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewManagerProtocol {
    func rootView() -> UIViewController
}

class RootViewManager: RootViewManagerProtocol {
    func rootView() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller: ContactsViewController = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController

    }

}
