//
//  signUpViewController.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 18/09/21.
//

import UIKit
import Firebase
import FirebaseAuth
import Spring
import SPPermissions
import JGProgressHUD
class signUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    let globHud = JGProgressHUD.init()
    @IBOutlet weak var inputTf: SpringTextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var inputPrompt: UILabel!
    
    var imgData:Data?=nil
    var imagePicker = UIImagePickerController()
    
    var counter = 0
    var email = ""
    var name = ""
    var password = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.showNavBar()
        self.hideKeyboardWhenTappedAround()
        self.submitBtn.layer.cornerRadius = 10
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTf()
        askPermissions()

    }
    //image choosing functions

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                let img = pickedImage.pngData()
                self.imgData = img
                print(pickedImage.size)
                self.imagePicker.dismiss(animated: true, completion: nil)
                self.counter+=1
                self.submitBtn.setTitle("All done!", for: .normal)
            }

        }
    @IBAction func submitTouched(_ sender: Any) -> Void{
        var photoURL:String=""
        //counter 0 - email
        //counter 1 - name
        //counter 2 - password
        if(counter==0){
            if(inputTf.text != "" && isValidEmail(inputTf.text!)){
                self.email = inputTf.text!
                counter+=1
                self.inputTf.text = ""
                self.inputPrompt.text = "What's your name?"
            }else if !isValidEmail(inputTf.text!){
                showAlert(msg: "That doesn't look like a valid email!")
            }else{
                showAlert(msg: "You can't leave this field blank.")
            }
        }else if(counter==1){
            if(inputTf.text != ""){
                self.name = inputTf.text!
                counter+=1
                self.inputTf.text = ""
                self.inputPrompt.text = "Enter a password here."
                self.inputTf.isSecureTextEntry = true
            }else{
                showAlert(msg: "You can't leave this field blank.")
            }
        }else if(counter==2){
            if(inputTf.text!.count<0){
                showAlert(msg: "You need a longer password!")
            }else{
                self.inputPrompt.text = "Now, you'll need to select a photo for your profile."
                self.inputTf.isHidden = true
                self.inputPrompt.lineBreakMode = .byWordWrapping
                counter+=1
                self.password = inputTf.text!
            }
        }else if(counter==3){
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = true
                present(imagePicker, animated: true, completion: nil)
            }
        }else{
            self.globHud.show(in: self.view)
            Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                    if(error != nil){
                        self.globHud.dismiss()
                        showAlert(msg: "An error occured while signing up. \(String(describing: error))")
                    }else{
                        //user has been created.
                        // step-1 create node in firebase db
                        // step-2 init userclass instance
                        // step-3 perform segue
                        var downloadUrl:URL!
                        let storage = Storage.storage()
                        let ref = Database.database().reference().child("user-node").child(splitString(str: self.email, delimiter: "."))
                        let st_ref = storage.reference().child("user-imgs").child(ref.key!)
                        _ = st_ref.putData(self.imgData!, metadata: nil) { (metadata, error) in
                                if(error != nil){
                                    showAlert(msg: error!.localizedDescription)
                                    self.globHud.dismiss()
                                }else{
                                    st_ref.downloadURL { (url, error) in
                                    if(error != nil){
                                        showAlert(msg: error!.localizedDescription)
                                        self.globHud.dismiss()
                                    }else if(url != nil){
                                        print("URL fetched with success.\n")
                                        downloadUrl = url!
                                        photoURL = downloadUrl.absoluteString
                                    let userDic:[String:Any]=[
                                        "email":self.email,
                                        "name":self.name,
                                        "photoURL":downloadUrl.absoluteString
                                    ];
                ref.setValue(userDic) { (error, ref) -> Void in
                                if(error == nil){
                                  
                                    self.globHud.dismiss()
                                    showSuccess(msg: "Signed in with success!")
                                }
                                else{
                                    self.globHud.dismiss()
                                    showAlert(msg: error!.localizedDescription)
                                }
                            }
                        }
                    else{
                        showAlert(msg: "Check your network, you may have issues.")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    func animateTf(){
        self.inputTf.animation = "squeezeLeft"
        self.inputTf.animate()
    }
    
    func askPermissions(){
        let controller = SPPermissions.dialog([.locationWhenInUse, .photoLibrary])
        controller.present(on: self)
    }
    
    func getInput() -> String{
        return self.inputTf.text!
    }
}


