//
//  RotatingWrapperView.swift
//  AutoLayoutRotationDemo
//
//  Copyright © 2019 Quantized Controls. All rights reserved.
//

import UIKit

class RotatingWrapperView: UIView {
    var wrapped: UIView
    
    var onRotate: (() -> ())? = nil
    
    init(_ wrappedView: UIView) {
        wrapped = wrappedView
        
        super.init(frame: .zero)
        
        self.addSubview(wrappedView)
        wrappedView.frame = self.bounds
        wrappedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    var rotation: UIInterfaceOrientation = .portrait {
        didSet {
            var transform: CGAffineTransform
            var flipped = false
            
            switch rotation {
            case .unknown:
                fallthrough
            case .portrait:
                transform = CGAffineTransform(rotationAngle: 0.0)
            case .portraitUpsideDown:
                transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case .landscapeLeft:
                flipped = true
                transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3.0 / 2.0)
            case .landscapeRight:
                flipped = true
                transform = CGAffineTransform(rotationAngle: CGFloat.pi * 1.0 / 2.0)
            }
            
            DispatchQueue.main.async {
                self.wrapped.transform = CGAffineTransform.identity
                
                if flipped {
                    self.wrapped.frame = self.bounds.flipped
                } else {
                    self.wrapped.frame = self.bounds
                }
                
                self.wrapped.transform = transform
                
                self.onRotate?()
            }
        }
    }
}

extension CGRect {
    public var flipped: CGRect {
        let xOffset = (width - height) / 2.0
        let yOffset = (height - width) / 2.0
        
        return CGRect(x: xOffset, y: yOffset, width: self.size.height, height: self.size.width)
    }
}
