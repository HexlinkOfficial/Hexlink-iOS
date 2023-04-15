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

struct AccountData : Codable {
    var name: String
}

let sendButtonRadius: CGFloat = 100;
let setupButtonRadius: CGFloat = 100;

final class HLHomeView: UIView, UITableViewDataSource {
    
    weak var delegate: HLHomeViewDelegate?
    let _titleLabel: UILabel = UILabel()
    let _subtitleLabel: UILabel = UILabel()
    let _accountTableView: UITableView = UITableView()
    let _setupButton: UIButton = UIButton()
    let _sendButton: UIButton = UIButton()
    var _accounts: [AccountData]?;

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _accounts = [AccountData(name: "Hexlink1"), AccountData(name: "Hexlink2")];
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        _titleLabel.text = "Hexlink"
        _titleLabel.textAlignment = .center
        addSubview(_titleLabel)
            
        _subtitleLabel.text = "Home"
        _subtitleLabel.textAlignment = .center
        addSubview(_subtitleLabel)
        
        _accountTableView.dataSource = self;
        _accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell")
        addSubview(_accountTableView);
        
        _setupButton.setTitle("setup", for: .normal)
        _setupButton.backgroundColor = UIColor.gray
//        _setupButton.layer.cornerRadius = 0.5 * sendButtonRadius
        _setupButton.clipsToBounds = true
        
        _setupButton.addTarget(self, action: #selector(setupButtonAction), for: .touchUpInside)
        addSubview(_setupButton)
        
        _sendButton.setTitle("send", for: .normal)
        _sendButton.backgroundColor = UIColor.gray
//        _sendButton.layer.cornerRadius = 0.5 * sendButtonRadius
        _sendButton.clipsToBounds = true
        
        _sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        addSubview(_sendButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleSize = _titleLabel.sizeThatFits(self.frame.size)
        _titleLabel.frame = CGRectMake(0, 100, self.frame.width, titleSize.height)
            
        let subtitleLabelSize = _subtitleLabel.sizeThatFits(self.frame.size)
        _subtitleLabel.frame = CGRectMake(0, _titleLabel.frame.maxY + 10, self.frame.width, subtitleLabelSize.height)
        
        _accountTableView.frame = CGRectMake(0, _subtitleLabel.frame.maxY + 20, self.frame.width, 100);
        
        _setupButton.frame = CGRectMake((self.frame.width - setupButtonRadius) / 2, self.frame.height - 200,
                                       setupButtonRadius, setupButtonRadius)
        
        _sendButton.frame = CGRectMake((self.frame.width - sendButtonRadius) / 2, _setupButton.frame.minY - 110,
                                      sendButtonRadius, sendButtonRadius)
    }
    
    @objc func setupButtonAction(sender: UIButton) {
        self.delegate?.homeViewSetupButtonTapped()
    }
    
    @objc func sendButtonAction(sender: UIButton) {
        self.delegate?.homeViewSendButtonTapped()
    }
    
//  UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath as IndexPath)
        cell.textLabel!.text = _accounts![indexPath.row].name
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _accounts!.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
}
