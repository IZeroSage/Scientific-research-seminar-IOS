//
//  WrittenWishCell.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    
    private let wishLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        wrap.translatesAutoresizingMaskIntoConstraints = false
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.addSubview(wishLabel)
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        wishLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.wrapOffsetV),
            wrap.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.wrapOffsetH),
            
            wishLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.wishLabelOffset),
            wishLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.wishLabelOffset),
            wishLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wishLabelOffset),
            wishLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.wishLabelOffset)
        ])
    }
}
