//
//  HLHomeView.swift
//  Hexlink
//
//  Created by Yang Xi on 10/30/22.
//

import Foundation
import UIKit

protocol HLHomeViewDelegate: AnyObject {
    func homeViewSetupButtonTapped()
    func homeViewSendButtonTapped()
}

let sendButtonRadius: CGFloat = 100;
let setupButtonRadius: CGFloat = 100;

final class HLHomeView: UIView {
    
    weak var delegate: HLHomeViewDelegate?
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let setupButton: UIButton = UIButton()
    let sendButton: UIButton = UIButton()

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
            
        subtitleLabel.text = "Home"
        subtitleLabel.textAlignment = .center
        addSubview(subtitleLabel)
        
        setupButton.setTitle("setup", for: .normal)
        setupButton.backgroundColor = UIColor.gray
//        setupButton.layer.cornerRadius = 0.5 * sendButtonRadius
        setupButton.clipsToBounds = true
        
        setupButton.addTarget(self, action: #selector(setupButtonAction), for: .touchUpInside)
        addSubview(setupButton)
        
        sendButton.setTitle("send", for: .normal)
        sendButton.backgroundColor = UIColor.gray
//        sendButton.layer.cornerRadius = 0.5 * sendButtonRadius
        sendButton.clipsToBounds = true
        
        sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        addSubview(sendButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleSize = titleLabel.sizeThatFits(self.frame.size)
        titleLabel.frame = CGRectMake(0, 100, self.frame.width, titleSize.height)
            
        let subtitleLabelSize = subtitleLabel.sizeThatFits(self.frame.size)
        subtitleLabel.frame = CGRectMake(0, titleLabel.frame.maxY + 10, self.frame.width, subtitleLabelSize.height)
        
        setupButton.frame = CGRectMake((self.frame.width - setupButtonRadius) / 2, self.frame.height - 200,
                                       setupButtonRadius, setupButtonRadius)
        
        sendButton.frame = CGRectMake((self.frame.width - sendButtonRadius) / 2, setupButton.frame.minY - 110,
                                      sendButtonRadius, sendButtonRadius)
    }
    
    @objc func setupButtonAction(sender: UIButton) {
        self.delegate?.homeViewSetupButtonTapped()
    }
    
    @objc func sendButtonAction(sender: UIButton) {
        self.delegate?.homeViewSendButtonTapped()
    }
}
