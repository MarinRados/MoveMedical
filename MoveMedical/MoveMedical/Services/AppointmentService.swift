//
//  AppointmentService.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation

protocol AppointmentServiceProtocol {
    func getAppointments() -> [Appointment]
    func createAppointment(_ appointment: Appointment)
    func updateAppointment(_ appointment: Appointment)
    func deleteAppointment(_ appointment: Appointment)
}

final class AppointmentService: AppointmentServiceProtocol {
    
    let defaults = UserDefaults.standard
    
    func getAppointments() -> [Appointment] {
        if let data = defaults.data(forKey: "appointments") {
            do {
                let decoder = JSONDecoder()
                let appointments = try decoder.decode([Appointment].self, from: data)
                return appointments
            } catch {
                print("Unable to Decode Appointment (\(error))")
            }
        }
        return []
    }
    
    private func updateList(_ appointments: [Appointment]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(appointments)
            
            defaults.set(data, forKey: "appointments")
            NotificationCenter.default.post(name: Notification.Name("listUpdated"), object: nil)

        } catch {
            print("Unable to Encode Appointment (\(error))")
        }
    }
    
    func createAppointment(_ appointment: Appointment) {
        var appointments = getAppointments()
        appointments.append(appointment)
        updateList(appointments)
    }
    
    func updateAppointment(_ appointment: Appointment) {
        var appointments = getAppointments()
        for (index, item) in appointments.enumerated() where item.id == appointment.id {
            appointments[index] = appointment
        }
        updateList(appointments)
    }
    
    func deleteAppointment(_ appointment: Appointment) {
        var appointments = getAppointments()
        for (index, item) in appointments.enumerated() where item.id == appointment.id {
            appointments.remove(at: index)
        }
        updateList(appointments)
    }
}
