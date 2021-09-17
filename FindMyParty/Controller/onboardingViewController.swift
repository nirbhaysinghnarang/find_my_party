//
//  onboardingViewController.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 17/09/21.
//

import UIKit
import AuthenticationServices
class onboardingViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @IBOutlet weak var pageCounter: UIPageControl!
    var i = 0;
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    

    @IBOutlet weak var carouselImg: UIImageView!
    @IBOutlet weak var loginProviderStackView: UIStackView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSOAppleSignIn()
        carouselImg.layer.cornerRadius = 10
        carouselImg.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        carouselImg.isUserInteractionEnabled = true
        carouselImg.addGestureRecognizer(tapGestureRecognizer)

        
    }
    func setupSOAppleSignIn() {
        let btnAuthorization = ASAuthorizationAppleIDButton()
        btnAuthorization.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        btnAuthorization.center = self.view.center
        self.loginProviderStackView.addArrangedSubview(btnAuthorization)
    }
    @objc func actionHandleAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
     
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
           print("authorised-with-success")
        }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.i+=1
        let imgNo = self.i%4
        let imgName = String(imgNo)+".png"
        self.pageCounter.currentPage = self.i%4
        self.carouselImg.image = UIImage(named: imgName)
    }

}
