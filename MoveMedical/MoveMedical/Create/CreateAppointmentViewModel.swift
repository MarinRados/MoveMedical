//
//  CreateAppointmentViewModel.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation

final class CreateAppointmentViewModel {
    
    private let appointmentService: AppointmentServiceProtocol
    init(appointmentService: AppointmentServiceProtocol) {
        self.appointmentService = appointmentService
    }
    
    let locations = ["San Diego", "St. George", "Park City", "Dallas", "Memphis", "Orlando"]
    
    func selectedLocationRow(savedLocation: String) -> Int {
        for (index, location) in locations.enumerated() where savedLocation == location {
            return index
        }
        return 0
    }
    
    func createAppointment(_ appointment: Appointment) {
        appointmentService.createAppointment(appointment)
    }
    
    func updateAppointment(_ appointment: Appointment) {
        appointmentService.updateAppointment(appointment)
    }
    
    func deleteAppointment(_ appointment: Appointment) {
        appointmentService.deleteAppointment(appointment)
    }
}
