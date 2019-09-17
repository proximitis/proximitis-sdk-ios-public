//
//  ViewController.swift
//  FrameworkTest
//
//  Created by Jiří Markalous on 11/03/2019.
//  Copyright © 2019 Proximitis. All rights reserved.
//

import UIKit
import ProximitisFramework

class ListViewController: ProximitisListViewController {
        
    override var infoScreen: UIView? {
        get {
            return super.infoScreen
        }
        set {
            super.infoScreen = ProximitisInfoView(offset: topDistance, image: UIImage(named: "noCampaigns"), text: "Zatím nemáte žádné kampaně.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

