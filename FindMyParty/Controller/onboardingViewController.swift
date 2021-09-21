//
//  onboardingViewController.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 17/09/21.
//

import UIKit
import Spring
class onboardingViewController: UIViewController  {
    @IBOutlet weak var pageCounter: UIPageControl!
    @IBOutlet weak var carouselImg: SpringImageView!
    @IBOutlet weak var loginBtn: SpringButton!
    @IBOutlet weak var signUpBtn: SpringButton!
    var i = 0;
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavBar()
        self.loginBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)
        self.signUpBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)
        self.loginBtn.layer.cornerRadius = 10
        self.signUpBtn.layer.cornerRadius = 10
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn.animation = "squeezeLeft"
        self.signUpBtn.animation = "squeezeRight"
        self.loginBtn.animate()
        self.signUpBtn.animate()
        
        //setting up swiping for carousel
        carouselImg.layer.cornerRadius = 10
        
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(_:)))
        swipeGestureRecognizerLeft.direction = .left
        

        swipeGestureRecognizerLeft.direction = .left
        carouselImg.isUserInteractionEnabled = true
        carouselImg.addGestureRecognizer(swipeGestureRecognizerLeft)

        
    }
    @objc private func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("didSwipe")
        self.carouselImg.animation = "slideRight"
        self.carouselImg.animate()
        self.i+=1
        let imgNo = self.i%4
        let imgName = String(imgNo)+".png"
        self.pageCounter.currentPage = self.i%4
        self.carouselImg.image = UIImage(named: imgName)
        self.carouselImg.animation = "slideLeft"
        self.carouselImg.animate()
    }
    



}
