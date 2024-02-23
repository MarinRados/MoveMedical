//
//  MainCoordinator.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    
    private let navigationController = BaseNavigationController()
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = AppointmentsListViewModel(appointmentService: AppointmentService())
        let viewController = AppointmentsListViewController(viewModel: viewModel)
        viewController.viewModel.onShowCreate = { [weak self] in
            self?.showCreate()
        }
        viewController.viewModel.onShowEdit = { [weak self] appointment in
            self?.showEdit(appointment)
        }
        navigationController.viewControllers = [viewController]
        navigationController.showAsRoot()
        return navigationController
    }
    
    private func showCreate() {
        let viewModel = CreateAppointmentViewModel(appointmentService: AppointmentService())
        let viewController = CreateAppointmentViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }
    
    private func showEdit(_ appointment: Appointment) {
        let viewModel = CreateAppointmentViewModel(appointmentService: AppointmentService())
        let viewController = CreateAppointmentViewController(viewModel: viewModel, appointment: appointment)
        navigationController.present(viewController, animated: true)
    }
}
