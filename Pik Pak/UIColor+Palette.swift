//
//  UIColor+Palette.swift
//  Ultravisual
//
//  Extensions: Contains UIColor+Palette.swift and UIImag

//+Decompression.swift, which provide convenience methods that handle color 
// conversion and image decompression, respectively. The starter project uses 
//the color palette to start off with, and in a future step, you’ll switch to 
//using images and the decompression method.

import UIKit

extension UIColor {
  
  class func colorFromRGB(r: Int, g: Int, b: Int) -> UIColor {
    return UIColor(red: CGFloat(Float(r) / 255), green: CGFloat(Float(g) / 255), blue: CGFloat(Float(b) / 255), alpha: 1)
  }
  
  class func palette() -> [UIColor] {
    let palette = [
      UIColor.colorFromRGB(85, g: 0, b: 255),
      UIColor.colorFromRGB(170, g: 0, b: 170),
      UIColor.colorFromRGB(85, g: 170, b: 85),
      UIColor.colorFromRGB(0, g: 85, b: 0),
      UIColor.colorFromRGB(255, g: 170, b: 0),
      UIColor.colorFromRGB(255, g: 255, b: 0),
      UIColor.colorFromRGB(255, g: 85, b: 0),
      UIColor.colorFromRGB(0, g: 85, b: 85),
      UIColor.colorFromRGB(0, g: 85, b: 255),
      UIColor.colorFromRGB(170, g: 170, b: 255),
      UIColor.colorFromRGB(85, g: 0, b: 0),
      UIColor.colorFromRGB(170, g: 85, b: 85),
      UIColor.colorFromRGB(170, g: 255, b: 0),
      UIColor.colorFromRGB(85, g: 170, b: 255),
      UIColor.colorFromRGB(0, g: 170, b: 170)
    ]
    return palette
  }
  
}
