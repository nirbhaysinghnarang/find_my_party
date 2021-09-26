//
//  AppUtils.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 17/09/21.
//

import Foundation
import UIKit
import SCLAlertView

extension UIView {
    func addBackgroundImage(imgUrl: String, placeHolder: String){

    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension UINavigationController{
    func hideNavBar(){
        self.setNavigationBarHidden(true, animated: true)
    }
    func showNavBar(){
        self.setNavigationBarHidden(false, animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


func showAlert(msg:String){
    SCLAlertView().showError("Oops!", subTitle:msg)
}
func showSuccess(msg:String){
    SCLAlertView().showSuccess("Success", subTitle: msg)
}
func showNotice(msg:String){
    SCLAlertView().showNotice("Loading",subTitle:msg)
}
func showInfo(msg:String){
    SCLAlertView().showInfo("Here you go",subTitle:msg)
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
func splitString(str:String,delimiter:String) -> String{
    var returnString = ""
    for char in str {
        if(String(char) != delimiter){
            returnString += String(char)
        }else{
            returnString += String("-")
        }
    }
    return returnString
}
