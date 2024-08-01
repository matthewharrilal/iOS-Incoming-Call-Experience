//
//  IncomingCallViewController.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 7/31/24.
//

import UIKit

class IncomingCallViewController: UIViewController {
    
    private var expandableControlsHeightConstraint: NSLayoutConstraint!
    private var expandableControlsTopConstraint: NSLayoutConstraint!
    private var callCardViewBottomConstraint: NSLayoutConstraint!
    private var callCardViewTopConstraint: NSLayoutConstraint!
    
    private lazy var expandableControlsView: ExpandableControlsView = {
        let view = ExpandableControlsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.didChangeHeight = { [weak self] style in
            guard let self = self else { return }
            self.expandableControlsDidChangeHeight(style: style)
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
        expandableControlsTopConstraint = expandableControlsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        callCardViewBottomConstraint = callCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        callCardViewTopConstraint = callCardView.topAnchor.constraint(equalTo: expandableControlsView.bottomAnchor, constant: 250)
        
        NSLayoutConstraint.activate([
            expandableControlsTopConstraint,
            expandableControlsHeightConstraint,
            expandableControlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandableControlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            callCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            callCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            callCardViewTopConstraint
        ])
    }
}

extension IncomingCallViewController: ExpandableControlsDelegate {
    
    func didChangeLayoutOfControls(style: ExpandableControlsView.Style) {
        switch style {
        case .bottom:
            callCardViewTopConstraint.constant = 0
            expandableControlsTopConstraint.constant = UIScreen.main.bounds.height - (view.safeAreaInsets.top + 85)
            expandableControlsView.style = .bottom
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            }
            
            expandableControlsDidChangeHeight(style: .compact)
        case .compact, .full:
            break
        }
    }
    
    func expandableControlsDidChangeHeight(style: ExpandableControlsView.Style) {
        expandableControlsView.style = style
        let heightConstant: CGFloat = style == .full ? 200 : 60
        expandableControlsHeightConstraint.constant = heightConstant
        
        if style == .compact {
            expandableControlsView.hideExpandedControls()
        }
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { [weak self] completed in
            
            if completed && style == .full {
                self?.expandableControlsView.showExpandedControls()
            }
        }
    }
}
