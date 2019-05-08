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
//        UICollectionViewCell.appearance().layer.cornerRadius = 20


    }
}
