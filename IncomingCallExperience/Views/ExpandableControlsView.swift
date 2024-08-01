//
//  ExpandableControlsView.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 7/31/24.
//

import Foundation
import UIKit

class ExpandableControlsView: UIView {
    
    var didChangeHeight: ((Style) -> Void)?
    
    enum Style {
        case compact
        case full
        
        mutating func toggle() {
            self = (self == .compact) ? .full : .compact
        }
    }
    
    var style: Style = .compact
    
    private var containerViewHeightConstraint: NSLayoutConstraint!
    private var containerViewBottomConstraint: NSLayoutConstraint!
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = .gray
        return view
    }()
    
    private var firstExpandedControl: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 18
        view.alpha = 0
        return view
    }()
    
    private var secondExpandedControl: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 18
        view.alpha = 0
        return view
    }()
    
    private var thirdExpandedControl: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 18
        view.alpha = 0
        return view
    }()
    
    private var profileImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var expandButton: TappableButtonView = {
        let view = TappableButtonView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 18
        view.didTap = { [weak self] in
            self?.expandContainerView()
        }
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

extension ExpandableControlsView {
    
    func setup() {
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(timeStampLabel)
        containerView.addSubview(expandButton)
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerViewBottomConstraint,
            
            profileImageView.heightAnchor.constraint(equalToConstant: 36),
            profileImageView.widthAnchor.constraint(equalToConstant: 36),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeStampLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            timeStampLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            
            expandButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            expandButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            expandButton.heightAnchor.constraint(equalToConstant: 36),
            expandButton.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    func expandContainerView() {
        style.toggle()
        didChangeHeight?(style)
    }
    
    func showExpandedControls() {
        guard style == .full else { 
            [firstExpandedControl, secondExpandedControl, thirdExpandedControl].forEach {
                $0.removeFromSuperview()
            }
            return
        }
        
        [firstExpandedControl, secondExpandedControl, thirdExpandedControl].forEach { containerView.addSubview($0) }
        
        let spacing = (containerView.frame.width / 3) - 20
        
        NSLayoutConstraint.activate([
            firstExpandedControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            firstExpandedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstExpandedControl.heightAnchor.constraint(equalToConstant: 36),
            firstExpandedControl.widthAnchor.constraint(equalToConstant: 36),
            
            secondExpandedControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            secondExpandedControl.leadingAnchor.constraint(equalTo: firstExpandedControl.trailingAnchor, constant: spacing),
            secondExpandedControl.widthAnchor.constraint(equalToConstant: 36),
            secondExpandedControl.heightAnchor.constraint(equalToConstant: 36),
            
            thirdExpandedControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            thirdExpandedControl.leadingAnchor.constraint(equalTo: secondExpandedControl.trailingAnchor, constant: spacing),
            thirdExpandedControl.widthAnchor.constraint(equalToConstant: 36),
            thirdExpandedControl.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            [self.firstExpandedControl, self.secondExpandedControl, self.thirdExpandedControl].forEach {
                $0.alpha = 1
            }
        }
    }
    
    func hideExpandedControls() {
        UIView.animate(withDuration: 0.10) { [weak self] in
            guard let self = self else { return }
            [self.firstExpandedControl, self.secondExpandedControl, self.thirdExpandedControl].forEach {
                $0.alpha = 0
            }
        } completion: { [weak self] _ in
            guard let self = self else { return }
            [self.firstExpandedControl, self.secondExpandedControl, self.thirdExpandedControl].forEach {
                $0.removeFromSuperview()
            }
        }

    }
}
