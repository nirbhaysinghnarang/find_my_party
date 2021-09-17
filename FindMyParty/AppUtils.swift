//
//  AppUtils.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 17/09/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIView {
    func addBackgroundImage(imgUrl: String, placeHolder: String){
        let backgroundImage = UIImageView(frame: self.bounds)
        backgroundImage.kf.setImage(with: URL(string: imgUrl), placeholder: UIImage(named: placeHolder))
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
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
