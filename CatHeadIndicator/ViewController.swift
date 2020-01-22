//
//  ViewController.swift
//  CatHeadIndicator
//
//  Created by Olga Lidman on 04/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var circle: LoadingView!
    @IBOutlet weak var catHead: CatHead!
    @IBOutlet weak var checkMark: CheckMark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        circle.start()
        circle.setNeedsDisplay()
        catHead.setNeedsDisplay()
        checkMark.setNeedsDisplay()
    }
}

