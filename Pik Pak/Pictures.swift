//
//  Pictures.swift
//  Pik Pak
//
//  Created by Andrew on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit
import Firebase

class Pictures: NSObject {
   
    class func sendPictureToEvent(picture: UIImage,eventID: String) {
        //var scaledImage: UIImage = scaleUIImageToSize(picture, size: CGSizeMake(0.5*picture.size.width, 0.5*picture.size.height))
        var imageData: NSData = UIImageJPEGRepresentation(picture, 0.25)
        
        var imageString: NSString = imageData.base64EncodedStringWithOptions(.allZeros)
        
        //send to pictures list that contains data
        var rootRef = Firebase(url: "https://pikapic.firebaseio.com/")
        var photosRef = rootRef.childByAppendingPath("pictures/")
        let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
        var picDic = ["base64":imageString,"owner":uuid,"event":eventID]
        photosRef.childByAutoId().setValue(picDic)
    }
    
    class func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    class func upvote(pic:Picture)
    {
        var rootRef = Firebase(url: "https://pikapic.firebaseio.com/")
        var photosRef = rootRef.childByAppendingPath("pictures/")
        var picRef = photosRef.childByAppendingPath(pic.id)
        var updatedScore = pic.score + 1
        var scoreDict = ["Score":updatedScore]
        picRef.updateChildValues(scoreDict)
    }
    
    class func downvote(pic:Picture)
    {
        var rootRef = Firebase(url: "https://pikapic.firebaseio.com/")
        var photosRef = rootRef.childByAppendingPath("pictures/")
        var picRef = photosRef.childByAppendingPath(pic.id)
        var updatedScore = pic.score - 1
        var scoreDict = ["Score":updatedScore]
        picRef.updateChildValues(scoreDict)
    }
}
