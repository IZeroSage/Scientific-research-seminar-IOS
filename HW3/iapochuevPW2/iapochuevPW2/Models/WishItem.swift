//
//  WishItem.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//

import Foundation

// MARK: - Модель желания
struct WishItem: Codable {
    
    // MARK: Свойства
    let id: UUID
    var title: String
    let createdAt: Date
    
    // MARK: Инициализация
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
    }
}
