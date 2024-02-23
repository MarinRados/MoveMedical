//
//  CreateAppointmentViewModel.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation

final class CreateAppointmentViewModel {
    
    let locations = ["San Diego", "St. George", "Park City", "Dallas", "Memphis", "Orlando"]
    
    func selectedLocationRow(savedLocation: String) -> Int {
        for (index, location) in locations.enumerated() where savedLocation == location {
            return index
        }
        return 0
    }
}
