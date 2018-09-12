//
//  ViewController.swift
//  DemoApp
//
//  Created by Ergesa Collaku on 12.09.18.
//  Copyright © 2018 Ergesa Collaku. All rights reserved.
//

import UIKit
import KIKenBurnEffect

class ViewController: UIViewController {
    
    @IBOutlet weak var animatedImageView: KenBurnEffect!
    var imagesNames = ["sample-3", "sample-2", "sample-1"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animatedImageView.startAnimation(imagesArray: imagesNames, timeDuration: 15)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.animatedImageView.stopAnimation()
    }
    
}

