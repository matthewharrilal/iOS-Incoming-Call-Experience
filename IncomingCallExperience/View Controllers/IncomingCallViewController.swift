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
        
        NSLayoutConstraint.activate([
            expandableControlsTopConstraint,
            expandableControlsHeightConstraint,
            expandableControlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandableControlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            callCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            callCardViewBottomConstraint,
            callCardView.topAnchor.constraint(equalTo: expandableControlsView.bottomAnchor, constant: 250)
        ])
    }
}

extension IncomingCallViewController: ExpandableControlsDelegate {
    
    func didChangeLayoutOfControls(style: ExpandableControlsView.Style) {
        let spacing: CGFloat
        expandableControlsView.style = style

        switch style {
        case .compactBottom:
            spacing = UIScreen.main.bounds.height - (view.safeAreaInsets.top + 200)

            callCardViewBottomConstraint.constant = spacing
            expandableControlsTopConstraint.constant = spacing
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            }
            
            expandableControlsDidChangeHeight(style: .compact)
            break
        case .compactTop:
            spacing = view.safeAreaInsets.top

            callCardViewBottomConstraint.constant = 0
            expandableControlsTopConstraint.constant = spacing
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            }

            expandableControlsDidChangeHeight(style: .compact)
            break
        case .compact:
            expandableControlsDidChangeHeight(style: .compact)
            break
        case .full:
//            expandableControlsDidChangeHeight(style: .full)
            break
        }
        
        
    }
    
    func expandableControlsDidChangeHeight(style: ExpandableControlsView.Style) {
        expandableControlsView.style = style
        
        if style == .compact {
            expandableControlsView.hideExpandedControls()
        }

        let heightConstant: CGFloat = style == .full ? 200 : 60
        expandableControlsHeightConstraint.constant = heightConstant
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { [weak self] completed in
            
            if completed && style == .full {
                self?.expandableControlsView.showExpandedControls()
            }
        }
    }
}
