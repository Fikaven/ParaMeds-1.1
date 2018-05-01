//
//  ViewController.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var adultmain: UIButton!
    @IBOutlet weak var pedMain: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adultmain.layer.shadowColor = UIColor.black.cgColor
        adultmain.layer.shadowOpacity = 0.5
        adultmain.layer.shadowOffset = CGSize.zero
        adultmain.layer.shadowRadius = 2
        
        pedMain.layer.shadowColor = UIColor.black.cgColor
        pedMain.layer.shadowOpacity = 0.5
        pedMain.layer.shadowOffset = CGSize.zero
        pedMain.layer.shadowRadius = 2
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func adultButton(_ sender: Any) {
        
        performSegue(withIdentifier: "goToAdultDrugs", sender: self)
    }
    
    @IBAction func pediatricButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPedDrugs", sender: self)
    }
}
extension UINavigationController {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

