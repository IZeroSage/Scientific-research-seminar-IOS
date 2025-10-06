//
//  WishItem.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//

import Foundation

struct WishItem: Codable {
    let id: UUID
    var title: String
    let createdAt: Date
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
    }
}
