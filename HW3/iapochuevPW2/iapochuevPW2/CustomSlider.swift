//
//  CustomSlider.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//

import UIKit

// MARK: - Кастомный слайдер
final class CustomSlider: UIView {
    
    // MARK: - Колбэк изменения значения
    var valueChanged: ((Double) -> Void)?
    
    // MARK: - UI элементы
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK: - Текущее значение
    var currentValue: Double {
        return Double(slider.value)
    }
    
    // MARK: - Инициализация
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.value = Float((min + max) / 2)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Настройка UI
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }

    // MARK: - Обработка изменения значения
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
