//
//  HLHomeViewController.swift
//  Hexlink
//
//  Created by Yang Xi on 10/30/22.
//

import Foundation
import UIKit

class HLHomeViewController: UIViewController {
  
    private var homeView: HLHomeView = HLHomeView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeView.frame = self.view.frame
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(homeView)
    }

}
