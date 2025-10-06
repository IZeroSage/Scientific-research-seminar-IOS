//
//  AddWishCell.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//


import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId = "AddWishCell"
    
    private let textView = UITextView()
    private let addButton = UIButton(type: .system)
    
    var addWish: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.text = "Enter your wish..."
        textView.textColor = .lightGray
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add Wish", for: .normal)
        addButton.backgroundColor = .systemPink
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
        
        contentView.addSubview(textView)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 80),
            
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            addButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        textView.delegate = self
    }
    
    @objc private func addButtonPressed() {
        guard let text = textView.text, !text.isEmpty, text != "Enter your wish..." else { return }
        addWish?(text)
        textView.text = ""
    }
}

extension AddWishCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your wish..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your wish..."
            textView.textColor = .lightGray
        }
    }
}
