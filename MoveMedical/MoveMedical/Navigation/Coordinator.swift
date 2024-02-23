//
//  Coordinator.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    
    @discardableResult
    func start() -> UIViewController
}
