//
//  AppointmentTableViewCell.swift
//  MoveMedical
//
//  Created by Marin on 23.02.2024..
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.colorFromHex(hex: "49454F")
        containerView.layer.cornerRadius = 10
        contentView.addSubview(containerView)
        return containerView
    }()
    
    private lazy var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.colorFromHex(hex: "#F7F2FA")
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.colorFromHex(hex: "#F7F2FA")
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        contentView.addSubview(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        containerView.anchor(top: (contentView.topAnchor, 8), bottom: (contentView.bottomAnchor, 8), leading: (contentView.leadingAnchor, 16), trailing: (contentView.trailingAnchor, 16))
        descriptionLabel.anchor(top: (containerView.topAnchor, 16), leading: (containerView.leadingAnchor, 16), trailing: (containerView.trailingAnchor, 16))
        locationLabel.anchor(bottom: (containerView.bottomAnchor, 10), leading: (descriptionLabel.leadingAnchor, 0))
        dateTimeLabel.anchor(bottom: (containerView.bottomAnchor, 10), trailing: (containerView.trailingAnchor, 16))
        containerView.addShadow(offset: CGSize(width: 0, height: 3), color: UIColor.black, radius: 3, opacity: 0.2)
    }
    
    var model: Appointment? {
        didSet {
            guard let model = model else { return }
            descriptionLabel.text = model.description
            locationLabel.text = model.location
            dateTimeLabel.text = model.date.formatted()
        }
    }
}
