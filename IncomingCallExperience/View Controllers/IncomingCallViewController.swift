//
//  IncomingCallViewController.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 7/31/24.
//

import UIKit

class IncomingCallViewController: UIViewController {
    
    private var expandableControlsHeightConstraint: NSLayoutConstraint!
    
    private lazy var expandableControlsView: ExpandableControlsView = {
        let view = ExpandableControlsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.didChangeHeight = { [weak self] style in
            guard let self = self else { return }
            
            let heightConstant: CGFloat = style == .full ? 200 : 60
            expandableControlsHeightConstraint.constant = heightConstant
            
            if style == .compact {
                view.hideExpandedControls()
            }
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            } completion: { [weak self] completed in
                
                if completed && style == .full {
                    view.showExpandedControls()
                }
            }

        }
        return view
    }()
    
    private var callCardView: CallCardView = {
        let view = CallCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
}

private extension IncomingCallViewController {
    
    func setup() {
        view.addSubview(expandableControlsView)
        view.addSubview(callCardView)
        view.backgroundColor = .white
        
        expandableControlsHeightConstraint = expandableControlsView.heightAnchor.constraint(equalToConstant: 60)
        
        NSLayoutConstraint.activate([
            expandableControlsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            expandableControlsHeightConstraint,
            expandableControlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandableControlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            callCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            callCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension IncomingCallViewController: ExpandableControlsDelegate {
    
    func didChangeLayoutOfControls(style: ExpandableControlsView.Style) {
        switch style {
        case .compact:
            callCardView.expandCallCardView()
        case .full:
            callCardView.shrinkCallCardView()
        }
    }
}

