//
//  KenBurnEffect.swift
//  KIKenBurnEffect
//
//  Created by Ergesa Collaku on 09.09.18.
//  Copyright © 2018 Ergesa Collaku. All rights reserved.
//

import UIKit

@IBDesignable public final class KenBurnEffect: UIImageView {
    
    public var isAnimationStarted = true
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    public func startAnimation(imagesArray: [String], timeDuration: TimeInterval) {
        self.isAnimationStarted = true
        self.animate(timeDuration: timeDuration, imagesArray: imagesArray)
    }
    
    public func stopAnimation() {
        self.isAnimationStarted = false
    }
    
    private func animate(for imageIndex: Int = 0, timeDuration: TimeInterval, imagesArray: [String]) {
        var currentImageIndex = imageIndex
        guard let image = UIImage(named: imagesArray[imageIndex % imagesArray.count]), self.isAnimationStarted else {
            self.layer.removeAllAnimations()
            return
        }
        UIView.animate(withDuration: timeDuration, delay: 0, options: [.curveEaseInOut, .beginFromCurrentState], animations: { [weak self] in
            self?.fadeOutImageView(for: image)
            }, completion: { _ in
                UIView.animate(withDuration: timeDuration, animations: { [weak self] in
                    self?.scaleTransformImageView()
                    }, completion: { [weak self] _ in
                        currentImageIndex += 1
                        self?.animate(for: currentImageIndex, timeDuration: timeDuration, imagesArray: imagesArray)
                })
        })
    }
    
    private func fadeOutImageView(for image: UIImage) {
        self.layer.removeAllAnimations()
        self.image = image
        self.transform = CGAffineTransform.identity
        let animation = CATransition()
        animation.duration = 1
        animation.type = kCATransitionFade
        self.layer.add(animation, forKey: nil)
    }
    
    private func scaleTransformImageView() {
        let scaleTrans = CGAffineTransform(scaleX: 1.25, y: 1.25)
        let imageTransform = CGAffineTransform(translationX: -20.0, y: -20.0)
        self.transform = scaleTrans.concatenating(imageTransform)
    }
    
}
