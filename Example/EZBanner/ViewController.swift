//
//  ViewController.swift
//  EZBanner
//
//  Created by NickYuu on 07/18/2017.
//  Copyright (c) 2017 NickYuu. All rights reserved.
//

import UIKit
import EZBanner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ezpv = EZBanner.create([#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3")])
        ezpv.start()
        ezpv.center = view.center
        view.addSubview(ezpv)
    }

}

