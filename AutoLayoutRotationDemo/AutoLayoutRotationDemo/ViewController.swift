//
//  ViewController.swift
//  AutoLayoutRotationDemo
//
//  Copyright © 2019 Quantized Controls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wrapperView: RotatingWrapperView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentsView = ContentsView()
        wrapperView = RotatingWrapperView(contentsView)
        
        wrapperView.onRotate = {
            contentsView.resetAnimations()
        }
        
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wrapperView)
        
        NSLayoutConstraint.activate(
            [
                NSLayoutConstraint(item: wrapperView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: wrapperView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: wrapperView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: wrapperView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0),
                ]
        )
        
        self.debugRotating()
    }
    
    var currentRotation = UIInterfaceOrientation.portrait
    func debugRotating() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            switch self.currentRotation {
            case .unknown:
                self.currentRotation = .portrait
            case .portrait:
                self.currentRotation = .landscapeRight
            case .portraitUpsideDown:
                self.currentRotation = .landscapeLeft
            case .landscapeRight:
                self.currentRotation = .portraitUpsideDown
            case .landscapeLeft:
                self.currentRotation = .portrait
            }
            
            self.wrapperView.rotation = self.currentRotation
            
            self.debugRotating()
        }
    }
}
