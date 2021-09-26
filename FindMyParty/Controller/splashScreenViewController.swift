//
//  ViewController.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 17/09/21.
//

import UIKit
import Spring
import Firebase
import JGProgressHUD

var globalUser = MainUser(name: "", photoURL: "", email: "", partiesAttended: 0, groupsCreated: [], groupsPartOf: [])


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
        if(Auth.auth().currentUser != nil){
            print("user not nil")
            let localHud = JGProgressHUD.init()
        localHud.show(in: self.view,animated: true)
        var email = Auth.auth().currentUser?.email
        email = splitString(str: email!, delimiter: ".")
        let ref = Database.database().reference().child("user-node").child(email!)
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value!["name"] as! String
            let email = value!["email"] as! String
            let photoURL = value!["photoURL"] as! String
            
            let partiesAttended = value!["partiesAttended"] as! Int
            let groupsCreated = value!["groupsCreated"] as? [PartyGroup] ?? []
            let groupsPartOf = value!["groupsPartOf"] as? [PartyGroup] ?? []
            
           
            globalUser = MainUser(name: name, photoURL: photoURL, email: email, partiesAttended: partiesAttended, groupsCreated: groupsCreated, groupsPartOf: groupsPartOf)
            localHud.dismiss()
            self.performSegue(withIdentifier: "toDashboard", sender: self)
            }){ (error) in
                    print(error.localizedDescription)
                    showAlert(msg: error.localizedDescription)
                    }
                }
    }
}

