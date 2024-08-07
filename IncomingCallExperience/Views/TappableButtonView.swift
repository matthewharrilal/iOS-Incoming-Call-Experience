//
//  TappableButtonView.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 7/31/24.
//

import Foundation
import UIKit

class TappableButtonView: UIView {
    
    var didTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TappableButtonView {
    
    func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onButtonTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func onButtonTap() {
        didTap?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
                
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
                
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.transform = .identity
        }
    }
}
