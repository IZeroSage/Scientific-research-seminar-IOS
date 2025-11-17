//
//  WishMakerViewController.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: - UI элементы
    private let titleLabel = UILabel()
    private let addWishButton = UIButton(type: .system)
    private let stackView = UIStackView()

    private var redSlider: CustomSlider!
    private var greenSlider: CustomSlider!
    private var blueSlider: CustomSlider!
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Настройка UI
    private func configureUI() {
        view.backgroundColor = UIColor(
            red: 0.8,
            green: 0.3,
            blue: 0.6,
            alpha: 1.0
        )
        
        configureTitle()
        configureAddWishButton()
        configureSliders()
    }
    
    // MARK: - Все так же настройка UI
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "WishMaker"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    // MARK: - Настройка кнопки желаний
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle("Write Down Wish", for: .normal)
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        addWishButton.layer.cornerRadius = 16
        addWishButton.layer.shadowColor = UIColor.black.cgColor
        addWishButton.layer.shadowOpacity = 0.2
        addWishButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        addWishButton.layer.shadowRadius = 4
        
        view.addSubview(addWishButton)
        
        NSLayoutConstraint.activate([
            addWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addWishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addWishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addWishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Конфигурация слайдера
    private func configureSliders() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 16
        stackView.layer.masksToBounds = true
        
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 4
        
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        redSlider = CustomSlider(title: "Red", min: 0, max: 1)
        greenSlider = CustomSlider(title: "Green", min: 0, max: 1)
        blueSlider = CustomSlider(title: "Blue", min: 0, max: 1)
        
        redSlider.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        greenSlider.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        blueSlider.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        
        view.addSubview(stackView)
        
        [redSlider, greenSlider, blueSlider].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: addWishButton.topAnchor, constant: -20)
        ])
    }
    
    // MARK: - Обновление фона
    private func updateBackgroundColor() {
        let red = CGFloat(redSlider.currentValue)
        let green = CGFloat(greenSlider.currentValue)
        let blue = CGFloat(blueSlider.currentValue)
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        let brightness = (red * 0.299 + green * 0.587 + blue * 0.114)
        titleLabel.textColor = brightness > 0.5 ? .black : .white
    }
    
    // MARK: - Действия с кнопкой
    @objc private func addWishButtonPressed() {
        let wishStoringVC = WishStoringViewController()
        present(wishStoringVC, animated: true)
    }
}
