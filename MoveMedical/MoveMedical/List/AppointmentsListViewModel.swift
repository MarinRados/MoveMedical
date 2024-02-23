//
//  AppointmentsListViewModel.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation

final class AppointmentsListViewModel {
    
    var appointments: [Appointment] = []
    private let appointmentService: AppointmentServiceProtocol
    
    init(appointmentService: AppointmentServiceProtocol) {
        self.appointmentService = appointmentService
    }
    
    var onShowEdit: ((Appointment)-> Void)?
    var onShowCreate: (()-> Void)?
    
    func getAppointments() {
        appointments = appointmentService.getAppointments()
    }
    
    func deleteAppointment(at index: Int) {
        appointmentService.deleteAppointment(appointments[index])
    }
    
    func showCreate() {
        onShowCreate?()
    }
    
    func showEdit(index: Int) {
        onShowEdit?(appointments[index])
    }
}
