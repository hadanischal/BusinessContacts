//
//  RootViewManager.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/26/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

protocol ViewManagers{
    func rootView() -> UIViewController
}

class RootViewManager {}

extension RootViewManager: ViewManagers {
    func rootView() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller: ContactsViewController = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
        
    }
    
}


