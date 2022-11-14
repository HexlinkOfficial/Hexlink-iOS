//
//  HLLoginViewController.swift
//  Hexlink
//
//  Created by Yang Xi on 10/29/22.
//

import Foundation
import UIKit

import FirebaseAuth


class HLLoginViewController: UIViewController, HLLoginViewDelegate {
  
    private var loginView: HLLoginView = HLLoginView()
    private var oauthProvider: OAuthProvider!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginView.delegate = self
        loginView.frame = self.view.frame
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(loginView)
    }
    
    func loginViewLoginButtonTapped() {
//        oauthProvider = OAuthProvider(providerID: "twitter.com")
//        oauthProvider.getCredentialWith(nil) { credential, error in
//            guard error == nil else {
//                print("ⓧ Error in signin : \(error?.localizedDescription ?? "")")
//                return
//            }
//            guard let credential = credential else { return }
//            Auth.auth().signIn(with: credential) { result, error in
//                guard error == nil else {
//                    print("ⓧ Error in signin : \(error?.localizedDescription ?? "")")
//                    return
//                }
//                let homeViewController = HLHomeViewController()
//                homeViewController.modalPresentationStyle = .fullScreen
//                self.present(homeViewController, animated: false)
//            }
//        }
        let homeViewController = HLHomeViewController()
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: false)
    }
}
