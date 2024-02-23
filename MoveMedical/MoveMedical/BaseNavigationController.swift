//
//  BaseNavigationController.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import UIKit

open class BaseNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white,
             .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        view.backgroundColor = UIColor.colorFromHex(hex: "1D1B20")
        navigationBar.tintColor = .black
    }
}
