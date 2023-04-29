//
//  HLInternalSettingView.swift
//  Hexlink
//
//  Created by Yang Xi on 4/15/23.
//

import Foundation
import UIKit

protocol HLInternalSettingViewDelegate: AnyObject {
    func internalSettingViewSetupButtonTapped()
    func internalSettingViewSendButtonTapped()
}

let buttonWidth: CGFloat = 100;
let buttonHeight: CGFloat = 30;

final class HLInternalSettingView: UIView {
    
    weak var delegate: HLInternalSettingViewDelegate?
    let _setupButton: UIButton = UIButton()
    let _sendButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        
        _setupButton.setTitle("setup the account", for: .normal)
        _setupButton.backgroundColor = UIColor.gray
        
        _setupButton.addTarget(self, action: #selector(setupButtonAction), for: .touchUpInside)
        addSubview(_setupButton)
        
        _sendButton.setTitle("send notification", for: .normal)
        _sendButton.backgroundColor = UIColor.gray
        
        _sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        addSubview(_sendButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        _setupButton.frame = CGRectMake((self.frame.width - buttonWidth) / 2, self.frame.height - 200,
                                        buttonWidth, buttonHeight)
        
        _sendButton.frame = CGRectMake((self.frame.width - buttonWidth) / 2, _setupButton.frame.minY - 110,
                                       buttonWidth, buttonHeight)
    }
    
    @objc func setupButtonAction(sender: UIButton) {
        self.delegate?.internalSettingViewSetupButtonTapped()
    }
    
    @objc func sendButtonAction(sender: UIButton) {
        self.delegate?.internalSettingViewSendButtonTapped()
    }
}
