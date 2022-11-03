//
//  HLHomeView.swift
//  Hexlink
//
//  Created by Yang Xi on 10/30/22.
//

import Foundation
import UIKit

protocol HLHomeViewDelegate: AnyObject {
    func homeViewSendButtonTapped()
}

final class HLHomeView: UIView {
    
    weak var delegate: HLHomeViewDelegate?
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
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
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = UIColor.gray
        sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        addSubview(sendButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleSize = titleLabel.sizeThatFits(self.frame.size)
        titleLabel.frame = CGRectMake(0, 100, self.frame.width, titleSize.height)
            
        let subtitleLabelSize = subtitleLabel.sizeThatFits(self.frame.size)
        subtitleLabel.frame = CGRectMake(0, titleLabel.frame.maxY + 10, self.frame.width, subtitleLabelSize.height)
        
        let sendButtonWidth : CGFloat = 200
        let sendButtonHeight : CGFloat = 50
        sendButton.frame = CGRectMake((self.frame.width - sendButtonWidth) / 2,
                                       600, sendButtonWidth, sendButtonHeight)
    }
    
    @objc func sendButtonAction(sender: UIButton) {
        self.delegate?.homeViewSendButtonTapped()
    }
}
