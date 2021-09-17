//
//  ViewController.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 17/09/21.
//

import UIKit
import Spring
class splashScreenViewController: UIViewController {
    @IBOutlet weak var heroTxtView: SpringImageView!
    @IBOutlet weak var heroImgView: SpringImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ApplicationHasLoaded")
        heroImgView.animation = "squeezeDown"
        heroImgView.animate()
        
        heroTxtView.animation = "swing"
        heroTxtView.animate()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavBar()
    }
}

