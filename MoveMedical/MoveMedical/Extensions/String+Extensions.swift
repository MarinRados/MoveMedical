//
//  String+Extensions.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation
import UIKit

extension String {
    
    public var isEmptyOrWhitespace: Bool {
        let whitespace = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace).isEmpty
    }
}
