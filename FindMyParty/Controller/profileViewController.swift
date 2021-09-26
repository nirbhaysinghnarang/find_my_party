//
//  profileViewController.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 26/09/21.
//

import UIKit
import Spring
class profileViewController: UIViewController {

    @IBOutlet weak var profileImg: SpringImageView!
    @IBOutlet weak var nameLbl: SpringLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        profileImg.load(url:URL(string: globalUser.photoURL)!)
        nameLbl.text = "Hi, " + globalUser.name
        profileImg.layer.cornerRadius = profileImg.bounds.height/2
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = UIColor.purple.cgColor
    }
    override func viewDidAppear(_ animated: Bool) {
        profileImg.animation = "squeezeLeft"
        nameLbl.animation = "squeezeRight"
        profileImg.animate()
        nameLbl.animate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
}
