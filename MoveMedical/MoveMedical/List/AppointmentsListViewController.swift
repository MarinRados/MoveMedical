//
//  ListViewController.swift
//  MoveMedical
//
//  Created by Marin on 22.02.2024..
//

import UIKit

class AppointmentsListViewController: UIViewController {
    
    var viewModel: AppointmentsListViewModel
    
    // MARK: - Initializers
    
    init(viewModel: AppointmentsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorFromHex(hex: "1D1B20")
        navigationItem.title = "My appointments"
        let createButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createTapped))
        navigationItem.rightBarButtonItem = createButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateList), name: Notification.Name("listUpdated"), object: nil)
        viewModel.getAppointments()
        emptyStateLabel.isHidden = !viewModel.appointments.isEmpty
    }
    
    // MARK: - User Interaction
    
    @objc private func updateList() {
        viewModel.getAppointments()
        tableView.reloadData()
        emptyStateLabel.isHidden = !viewModel.appointments.isEmpty
    }
    
    @objc private func createTapped() {
        viewModel.showCreate()
    }
    
    private func delete(at index: Int) {
        let alert = UIAlertController(title: "Delete appointment", message: "Are you sure you want to delete this appointment?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteAppointment(at: index)
        }))
        present(alert, animated: false)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        tableView.anchorToSafeArea()
        emptyStateLabel.centerYInSuperview()
        emptyStateLabel.anchor(leading: (view.leadingAnchor, 60), trailing: (view.trailingAnchor, 60))
    }
    
    // MARK: - UI Elements
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "You currently don't have any appointments scheduled. Tap here to schedule an appointment."
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(createTapped))
        label.addGestureRecognizer(tap)
        view.addSubview(label)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: "AppointmentTableViewCell")
        view.addSubview(tableView)
        return tableView
    }()
}

extension AppointmentsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as? AppointmentTableViewCell else { return UITableViewCell() }
        cell.model = viewModel.appointments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showEdit(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self else {return}
            self.delete(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

