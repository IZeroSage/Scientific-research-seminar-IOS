//
//  WishStoringViewController.swift
//  iapochuevPW2
//
//  Created by Иван Почуев on 07.10.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {

    // MARK: - Константы
    private enum Constants {
        static let wishesKey = "savedWishes"
        static let tableCornerRadius: CGFloat = 16
        static let tableOffset: CGFloat = 10
    }
    
    // MARK: - UI элементы
    private let table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Хранилище
    private let defaults = UserDefaults.standard
    
    // MARK: - Данные
    private var wishArray: [WishItem] = []
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        loadWishes()
        configureTable()
    }
    
    // MARK: - Конфигурация интерфейса
    private func configureTable() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableOffset),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableOffset),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.tableOffset),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.tableOffset)
        ])
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    // MARK: - Работа с хранилищем
    private func loadWishes() {
        if let savedData = defaults.data(forKey: Constants.wishesKey),
           let savedWishes = try? JSONDecoder().decode([WishItem].self, from: savedData) {
            wishArray = savedWishes
        }
    }
    
    private func saveWishes() {
        if let encoded = try? JSONEncoder().encode(wishArray) {
            defaults.set(encoded, forKey: Constants.wishesKey)
        }
    }
    
    // MARK: - Модификация данных
    private func addWish(_ wishText: String) {
        let newWish = WishItem(title: wishText)
        wishArray.append(newWish)
        saveWishes()
        table.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    
    // MARK: Секции таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: Количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return wishArray.count
        default: return 0
        }
    }
    
    // MARK: Конфигурация ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] wishText in
                self?.addWish(wishText)
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: wishArray[indexPath.row].title)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {
    
    // MARK: Выбор ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: Возможность редактирования
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    // MARK: Удаление строки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == 1 {
            wishArray.remove(at: indexPath.row)
            saveWishes()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
