//
//  HLAccountTableViewCell.swift
//  Hexlink
//
//  Created by Yang Xi on 4/25/23.
//

import UIKit

class HLAccountTableViewCell : UITableViewCell {
    
    private let _mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .white
        return mainView
    }()

    private let _accountImageView: UIImageView = {
        let _accountImageView = UIImageView(image: UIImage(named: "logo"))
        return _accountImageView
    }()
    
    private let _titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private let _subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        return subtitleLabel
    }()
    
    private let _moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: UIControl.State.normal)
        return moreButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        contentView.addSubview(_mainView)

        _mainView.addSubview(_accountImageView)
        _mainView.addSubview(_titleLabel)
        _mainView.addSubview(_subtitleLabel)
        _mainView.addSubview(_moreButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        _mainView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height - 10)

        _accountImageView.frame = CGRectMake(10, 10, 50, 50)
        _titleLabel.frame = CGRectMake(_accountImageView.frame.maxX + 10, 10, 100, 20)
        _subtitleLabel.frame = CGRectMake(_accountImageView.frame.maxX + 10, _titleLabel.frame.maxY + 2, 100, 20)
        
        _moreButton.sizeToFit()
        _moreButton.frame = CGRectMake(_mainView.frame.width - _moreButton.frame.width - 20,
                                       _mainView.frame.midY - _moreButton.frame.height / 2,
                                       _moreButton.frame.width,
                                       _moreButton.frame.height)
    }
    
    public func configure(title: String) {
        _titleLabel.text = title
        _subtitleLabel.text = "0xasdf...123"
    }
}
