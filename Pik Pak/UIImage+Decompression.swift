//
//  UIImage+Decompression.swift
//  
//
//  Extensions: Contains UIColor+Palette.swift and UIImage+Decompression.swift, which provide convenience methods that handle color conversion and image decompression, respectively. The starter project uses the color palette to start off with, and in a future step, you’ll switch to using images and the decompression method.
//

import UIKit

extension UIImage {
  
  var decompressedImage: UIImage {
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    drawAtPoint(CGPointZero)
    let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return decompressedImage
  }
  
}
