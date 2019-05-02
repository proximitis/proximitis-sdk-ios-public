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
    
    
    override var infoScreen: ProximitisInfoView? {
        get {
            return super.infoScreen
        }
        set {
            super.infoScreen = ProximitisInfoView(offset: topDistance, image: UIImage.init(named: "noCampaignsIcon", in: Bundle(for: ProximitisListViewController.self), compatibleWith: nil), text: "Žádné kampaně!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

