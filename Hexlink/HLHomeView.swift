//
//  HLHomeView.swift
//  Hexlink
//
//  Created by Yang Xi on 10/30/22.
//

import Foundation
import UIKit

struct AccountData : Codable {
    var name: String
}

final class HLHomeView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let _titleLabel: UILabel = UILabel()
    let _subtitleLabel: UILabel = UILabel()
    let _addAccountButton: UIButton = UIButton()
    let _accountTableView: UITableView = UITableView()
    var _accounts: [AccountData]?;

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _accounts = [AccountData(name: "Hexlink1"), AccountData(name: "Hexlink2")];
        setupViews()
        
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        _titleLabel.text = "Hexlink"
        _titleLabel.textAlignment = .left
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        addSubview(_titleLabel)
        
        _addAccountButton.setImage(UIImage(systemName: "plus"), for: UIControl.State.normal)
        addSubview(_addAccountButton)
        
        _accountTableView.dataSource = self;
        _accountTableView.delegate = self;
        _accountTableView.register(HLAccountTableViewCell.self, forCellReuseIdentifier: "AccountCell")
        _accountTableView.separatorStyle = .none
        _accountTableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        addSubview(_accountTableView);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleSize = _titleLabel.sizeThatFits(self.frame.size)
        _titleLabel.frame = CGRectMake(20, 80, self.frame.width, titleSize.height)
        
        _addAccountButton.sizeToFit()
        _addAccountButton.frame = CGRectMake(self.frame.width - 20 - self._addAccountButton.frame.width,
                                             _titleLabel.frame.midY - _addAccountButton.frame.height / 2,
                                             _addAccountButton.frame.width,
                                             _addAccountButton.frame.height);
        
        _accountTableView.frame = CGRectMake(20, _titleLabel.frame.maxY + 20, self.frame.width - 40, 400);
    }
    
//  UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell",
                                                 for: indexPath) as! HLAccountTableViewCell
        cell.configure(title: _accounts![indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _accounts!.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
//    UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }

}
