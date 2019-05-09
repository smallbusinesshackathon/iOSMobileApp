//
//  Appearance.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit
enum Appearance {
    
    static func setTheme() {
        
        // Style all segmented controls in app.
        UISegmentedControl.appearance().backgroundColor = .clear
        UISegmentedControl.appearance().tintColor = .clear
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.011998998, green: 0.4799926877, blue: 1, alpha: 1) ], for: .selected)
        
        // Style all collection view cells.
        UICollectionViewCell.appearance().backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        UICollectionViewCell.appearance().layer.masksToBounds = true

        // Style tab bar in app.
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.9342113733, green: 0.7635644078, blue: 0.07422252744, alpha: 1)
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9342113733, green: 0.7635644078, blue: 0.07422252744, alpha: 1) ], for: .selected)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) ], for: .normal)

    
    }
    
    static func setUpBlueButton(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
}
