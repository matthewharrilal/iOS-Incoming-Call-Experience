//
//  ExpandableControlsView.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 7/31/24.
//

import Foundation
import UIKit

class ExpandableControlsView: UIView {
    
    enum Style {
        case compact
        case full
    }
    
    var style: Style = .compact
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = .gray
        return view
    }()
    
    private var profileImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 18
        return view
    }()
    
    private var expandButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 18
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "John Doe"
        return label
    }()
    
    private var timeStampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:25"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExpandableControlsView {
    
    func setup() {
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(timeStampLabel)
        containerView.addSubview(expandButton)
        
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 36),
            profileImageView.widthAnchor.constraint(equalToConstant: 36),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeStampLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            timeStampLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            timeStampLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            expandButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            expandButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            expandButton.heightAnchor.constraint(equalToConstant: 36),
            expandButton.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
}
