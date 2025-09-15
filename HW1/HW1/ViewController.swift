//
//  ViewController.swift
//  HW1
//
//  Created by Иван Почуев on 16.09.2025.
//

import UIKit

class ViewController: UIViewController {
    // Outlets
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    
    // Parameters
    private enum Parameters {
        static let animationDuration: TimeInterval = 0.5
        static let minCornerRadius: CGFloat = 0
        static let maxCornerRadius: CGFloat = 25
    }
    
    // Just viewDidLoad :/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Change colors and cornerRadius with animate
    @IBAction func buttonWasPressed(_ sender: Any) {
        button.isEnabled = false
        let colors = getUniqueColors(count: views.count)
        let updateViews = {
            for (index, view) in self.views.enumerated() {
                view.backgroundColor = colors[index]
                view.layer.cornerRadius = CGFloat.random(in: Parameters.minCornerRadius...Parameters.maxCornerRadius)
            }
        }
        UIView.animate(
            withDuration: Parameters.animationDuration,
            animations: updateViews,
            completion: { [weak self] _ in
                self?.button.isEnabled = true
            }
        )
    }
    
    // HEX Colors
    private func getUniqueColors(count: Int) -> [UIColor] {
       var set = Set<String>()
       while set.count < count {
           let hex = String(format:"#%06X", Int.random(in: 0...0xFFFFFF))
           set.insert(hex)
       }
       return set.map { UIColor(hex: $0) }
    }
}

// UIColor Extension
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
