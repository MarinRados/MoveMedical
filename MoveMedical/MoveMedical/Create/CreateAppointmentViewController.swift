//
//  CreateAppointmentViewController.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import UIKit

class CreateAppointmentViewController: UIViewController {
    
    var viewModel: CreateAppointmentViewModel
    private let appointment: Appointment?
    
    // MARK: - Initializers
    
    init(viewModel: CreateAppointmentViewModel, appointment: Appointment? = nil) {
        self.viewModel = viewModel
        self.appointment = appointment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorFromHex(hex: "1D1B20")
        setupConstraints()
        if let appointment = appointment {
            textField.text = appointment.description
            datePicker.date = appointment.date
            locationPicker.selectRow(viewModel.selectedLocationRow(savedLocation: appointment.location), inComponent: 0, animated: false)
            descriptionLabel.text = "Appointment description"
            deleteButton.isHidden = false
            let attributedString = NSAttributedString(string: "Update Appointment", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.colorFromHex(hex: "1D1B20")
            ])
            createButton.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    // MARK: - User Interaction
    
    public func displayDescriptionWarning() {
        let alert = UIAlertController(title: "Empty description", message: "Please enter appointment description", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: false)
    }
    
    @objc private func createTapped() {
        guard let description = textField.text else {
            displayDescriptionWarning()
            return
        }
        let date = datePicker.date
        let location = viewModel.locations[locationPicker.selectedRow(inComponent: 0)]
        let uuid = UUID().uuidString
        let appointment = Appointment(id: uuid, description: description, date: date, location: location)
        viewModel.createAppointment(appointment)
        dismiss(animated: true)
    }
    
    @objc private func updateTapped() {
        guard let description = textField.text, let uuid = appointment?.id else {
            displayDescriptionWarning()
            return
        }
        let date = datePicker.date
        let location = viewModel.locations[locationPicker.selectedRow(inComponent: 0)]
        let appointment = Appointment(id: uuid, description: description, date: date, location: location)
        viewModel.updateAppointment(appointment)
        dismiss(animated: true)
    }
    
    @objc private func deleteTapped() {
        guard let appointment = appointment else { return }
        let alert = UIAlertController(title: "Delete appointment", message: "Are you sure you want to delete this appointment?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteAppointment(appointment)
            self?.dismiss(animated: true)
        }))
        present(alert, animated: false)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        textField.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 100), leading: (view.leadingAnchor, 40), trailing: (view.trailingAnchor, 40), size: CGSize(width: 0, height: 40))
        descriptionLabel.anchor(bottom: (textField.topAnchor, 10), leading: (textField.leadingAnchor, 0))
        locationPicker.centerXInSuperview()
        locationPicker.anchor(top: (textField.bottomAnchor, 30))
        datePicker.centerXInSuperview()
        datePicker.anchor(top: (locationPicker.bottomAnchor, 30))
        createButton.anchor(top: (datePicker.topAnchor, 100), leading: (view.leadingAnchor, 40), trailing: (view.trailingAnchor, 40), size: CGSize(width: 0, height: 56))
        deleteButton.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 40))
    }
    
    // MARK: - UI Elements
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Describe your appointment"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        view.addSubview(label)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.backgroundColor = .clear
        textField.tintColor = .white
        textField.layer.borderColor = UIColor.colorFromHex(hex: "49454F").cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .done
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        view.addSubview(textField)
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.tintColor = .black
        datePicker.minimumDate = Date()
        view.addSubview(datePicker)
        return datePicker
    }()
    
    private lazy var locationPicker: UIPickerView = {
        let locationPicker = UIPickerView()
        locationPicker.dataSource = self
        locationPicker.delegate = self
        view.addSubview(locationPicker)
        return locationPicker
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 56))
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.white
        let attributedString = NSAttributedString(string: "Create Appointment", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.colorFromHex(hex: "1D1B20")
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        if appointment != nil {
            button.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        }
        button.layer.cornerRadius = 15
        view.addSubview(button)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        let attributedString = NSAttributedString(string: "Delete", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        button.isHidden = true
        view.addSubview(button)
        return button
    }()
}

extension CreateAppointmentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.locations[row]
    }
}

extension CreateAppointmentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmptyOrWhitespace {
            displayDescriptionWarning()
        }
    }
}
