//
//  UIImage+faceRecognition.swift
//  KIKenBurnEffect
//
//  Created by Ergesa Collaku on 10.09.18.
//  Copyright © 2018 Ergesa Collaku. All rights reserved.
//

import UIKit

extension UIImage {
    
    var faces: [UIImage] {
        guard let ciimage = CIImage(image: self) else {
            return []
        }
        var orientation: NSNumber {
            switch imageOrientation {
            case .up:            return 1
            case .upMirrored:    return 2
            case .down:          return 3
            case .downMirrored:  return 4
            case .leftMirrored:  return 5
            case .right:         return 6
            case .rightMirrored: return 7
            case .left:          return 8
            }
        }
        return CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])?
            .features(in: ciimage, options: [CIDetectorImageOrientation: orientation])
            .compactMap {
                let rect = $0.bounds.insetBy(dx: -10, dy: -10)
                UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
                defer {
                    UIGraphicsEndImageContext()
                }
                UIImage(ciImage: ciimage.cropped(to: rect)).draw(in: CGRect(origin: .zero, size: rect.size))
                guard let face = UIGraphicsGetImageFromCurrentImageContext() else {
                    return nil
                }
                let size = face.size
                let breadth = min(size.width, size.height)
                let breadthSize = CGSize(width: breadth, height: breadth)
                UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
                defer {
                    UIGraphicsEndImageContext()
                }
                guard let cgImage = face.cgImage?.cropping(to: CGRect(origin: CGPoint(x: size.width > size.height ? (size.width-size.height).rounded(.down)/2 : 0, y: size.height > size.width ? (size.height-size.width).rounded(.down)/2 : 0), size: breadthSize))
                    
                    else {
                        return nil
                }
                let faceRect = CGRect(origin: .zero, size: CGSize(width: min(size.width, size.height), height: min(size.width, size.height)))
                UIImage(cgImage: cgImage).draw(in: faceRect)
                return UIGraphicsGetImageFromCurrentImageContext()
            } ?? []
    }
}
