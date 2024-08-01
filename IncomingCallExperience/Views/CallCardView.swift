//
//  CallCardView.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 8/1/24.
//

import Foundation
import UIKit

class CallCardView: UIView {
    
    private var needsCornerUpdates: Bool = true
    private var containerViewHeightConstraint: NSLayoutConstraint!
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if needsCornerUpdates {
            containerView.roundCorners(corners: [.topLeft, .topRight], radius: 18)
            needsCornerUpdates = false
        }
    }
}

extension CallCardView {
    
    func setup() {
        addSubview(containerView)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 450)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerViewHeightConstraint
        ])
    }
}
