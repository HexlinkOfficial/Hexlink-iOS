//
//  HLLoginView.swift
//  Hexlink
//
//  Created by Yang Xi on 10/29/22.
//

import Foundation
import UIKit

protocol HLLoginViewDelegate: AnyObject {
    func loginViewLoginButtonTapped()
}

final class HLLoginView: UIView {
    
    weak var delegate: HLLoginViewDelegate?
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let loginButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        titleLabel.text = "Hexlink"
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
            
        subtitleLabel.text = "Login your account"
        subtitleLabel.textAlignment = .center
        addSubview(subtitleLabel)
        
        loginButton.setTitle("Login with Twitter", for: .normal)
        loginButton.backgroundColor = UIColor.gray
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        addSubview(loginButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleSize = titleLabel.sizeThatFits(self.frame.size)
        titleLabel.frame = CGRectMake(0, 100, self.frame.width, titleSize.height)
            
        let subtitleLabelSize = subtitleLabel.sizeThatFits(self.frame.size)
        subtitleLabel.frame = CGRectMake(0, titleLabel.frame.maxY + 10, self.frame.width, subtitleLabelSize.height)
        
        let loginButtonWidth : CGFloat = 200
        let loginButtonHeight : CGFloat = 50
        loginButton.frame = CGRectMake((self.frame.width - loginButtonWidth) / 2,
                                       600, loginButtonWidth, loginButtonHeight)
    }
    
    @objc func loginButtonAction(sender: UIButton) {
        self.delegate?.loginViewLoginButtonTapped()
    }
}
