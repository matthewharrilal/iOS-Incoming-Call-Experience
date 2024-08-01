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
        view.didChangeHeight = { [weak self] heightConstant in
            guard let self = self else { return }
            
            expandableControlsHeightConstraint.constant = heightConstant
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            } completion: { [weak self] completed in
                
                if completed {
                    view.showExpandedControls()
                }
            }

        }
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
        view.backgroundColor = .white
        
        expandableControlsHeightConstraint = expandableControlsView.heightAnchor.constraint(equalToConstant: 60)
        
        NSLayoutConstraint.activate([
            expandableControlsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            expandableControlsHeightConstraint,
            expandableControlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandableControlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

