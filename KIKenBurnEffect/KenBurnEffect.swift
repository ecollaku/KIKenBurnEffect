//
//  KenBurnEffect.swift
//  KIKenBurnEffect
//
//  Created by Ergesa Collaku on 09.09.18.
//  Copyright © 2018 Ergesa Collaku. All rights reserved.
//

import UIKit

public final class KenBurnEffect: UIImageView {
    
    public var isAnimationStarted = true
    
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
        UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseInOut, .beginFromCurrentState], animations: { [weak self] in
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
