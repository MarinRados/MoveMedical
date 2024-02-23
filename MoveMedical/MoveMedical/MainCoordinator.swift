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
        let viewController = AppointmentsListViewController(viewModel: AppointmentsListViewModel())
        viewController.viewModel.onShowCreate = { [weak self] in
            self?.showCreate()
        }
        viewController.viewModel.onShowEdit = { [weak self] in
            self?.showEdit()
        }
        navigationController.viewControllers = [viewController]
        navigationController.showAsRoot()
        return navigationController
    }
    
    private func showCreate() {
        let viewController = CreateAppointmentViewController(viewModel: CreateAppointmentViewModel())
        navigationController.present(viewController, animated: true)
    }
    
    private func showEdit() {
        let viewController = CreateAppointmentViewController(viewModel: CreateAppointmentViewModel(), appointment: Appointment(description: "aaaaaa", date: Date(), location: "Dallas"))
        navigationController.pushViewController(viewController, animated: true)
    }
}
