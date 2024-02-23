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
        navigationItem.title = "Your appointments"
        let createButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createTapped))
        navigationItem.rightBarButtonItem = createButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        setupConstraints()
    }
    
    // MARK: - User Interaction
    
    @objc private func createTapped() {
        viewModel.showCreate()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        tableView.anchorToSafeArea()
    }
    
    // MARK: - UI Elements
    
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as? AppointmentTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showEdit()
    }
}

