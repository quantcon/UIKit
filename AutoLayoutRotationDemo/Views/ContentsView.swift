//
//  ContentsView.swift
//  AutoLayoutRotationDemo
//
//  Copyright © 2019 Quantized Controls. All rights reserved.
//

import UIKit

class ContentsView: UIView {
    var animatedLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.green.cgColor
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        let view1 = UILabel()
        view1.text = "🆙"
        view1.font = UIFont.systemFont(ofSize: 44.0)
        view1.textAlignment = .center
        view1.backgroundColor = .gray
        
        let view2 = UILabel()
        view2.text = "👆"
        view2.font = UIFont.systemFont(ofSize: 44.0)
        view2.textAlignment = .center
        view2.backgroundColor = .gray
        
        let view3 = UILabel()
        view3.text = "🆗"
        view3.font = UIFont.systemFont(ofSize: 44.0)
        view3.textAlignment = .center
        view3.backgroundColor = .gray
        
        stack.addArrangedSubview(view1)
        stack.addArrangedSubview(view2)
        stack.addArrangedSubview(view3)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        
        animatedLabel = UILabel()
        animatedLabel.font = UIFont.systemFont(ofSize: 44.0)
        animatedLabel.text = "🏎"
        animatedLabel.backgroundColor = .lightGray
        animatedLabel.textAlignment = .center
        
        animatedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animatedLabel)
        
        let margin: CGFloat = 25.0
        
        NSLayoutConstraint.activate(
            [
                NSLayoutConstraint(item: stack, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: margin),
                NSLayoutConstraint(item: stack, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -1 * margin),
                NSLayoutConstraint(item: stack, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: margin),
                NSLayoutConstraint(item: stack, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -1 * margin),
                
                NSLayoutConstraint(item: animatedLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55.0)
            ]
        )
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func resetAnimations() {
        self.removeConstraints(mutableConstraints)
        self.beginAnimating()
    }
    
    var mutableConstraints: [NSLayoutConstraint] = []
    
    func beginAnimating() {
        let fromConstraint = NSLayoutConstraint(item: animatedLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let toConstraint = NSLayoutConstraint(item: animatedLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        let vertConstraint = NSLayoutConstraint(item: animatedLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate(
            [
                fromConstraint,
                vertConstraint
            ]
        )
        
        mutableConstraints.append(contentsOf: [fromConstraint, toConstraint, vertConstraint])
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.animate(withDuration: 0.3) {
                NSLayoutConstraint.deactivate([fromConstraint])
                NSLayoutConstraint.activate([toConstraint])
                self.layoutIfNeeded()
            }
        }
    }
}
