//
//  MemeImageView.swift
//  MemeMe
//
//  Created by Sebastian on 05.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import Foundation
import UIKit


class MemeImageView: UIImageView, UIGestureRecognizerDelegate {
    
    private func initialize() {
        self.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action:  #selector(panGestureDetected))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureDetected))
        pinchGestureRecognizer.delegate = self
        self.addGestureRecognizer(pinchGestureRecognizer)
        
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action:  #selector(rotateGestureDetected))
        rotateGestureRecognizer.delegate = self
        self.addGestureRecognizer(rotateGestureRecognizer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func enableGestureRecogniztion() {
        self.isUserInteractionEnabled = true
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureDetected))
//        pinchGestureRecognizer.delegate = self
        
        self.addGestureRecognizer(pinchGestureRecognizer)
        
    }
    
     // handle UIRotateGestureRecognizer
    @objc func panGestureDetected(sender: UIPanGestureRecognizer) {
        let gview = sender.view
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: gview?.superview)
            gview?.center = CGPoint(x: (gview?.center.x)! + translation.x, y: (gview?.center.y)! + translation.y)
            sender.setTranslation(CGPoint.zero, in: gview?.superview)
        }
    }
    
    
    // handle UIPinchGestureRecognizer
    @objc func pinchGestureDetected(sender: UIPinchGestureRecognizer) {
        let state = sender.state
        if state == .began || state == .changed {
            let scale = sender.scale
            sender.view?.transform = (sender.view?.transform.scaledBy(x: scale, y: scale))!
            sender.scale = 1.0
        }
    }
    
    // handle UIRotateGestureRecognizer
    @objc func rotateGestureDetected(sender: UIRotationGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.rotated(by: sender.rotation))!
            sender.rotation = 0.0
        }
    }
    
    // mark sure you override this function to make gestures work together
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    
    
}
