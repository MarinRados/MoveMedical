//
//  AppointmentsListViewModel.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation

final class AppointmentsListViewModel {
    
    var onShowEdit: (()-> Void)?
    var onShowCreate: (()-> Void)?
    
    func showCreate() {
        onShowCreate?()
    }
    
    func showEdit() {
        onShowEdit?()
    }
}
