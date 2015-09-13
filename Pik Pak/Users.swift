//
//  Users.swift
//  Pik Pak
//
//  Created by Andrew on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit
import Firebase

class Users: NSObject {
    
    static var rootRef = Firebase(url: "https://pikapic.firebaseio.com/")
    static var usersRef = rootRef.childByAppendingPath("users")
    static let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString

    class func getUserInfo() -> Void
    {
        usersRef.observeEventType(.Value, withBlock: { snapshot in
            println(snapshot.value)
        })
    }
    
    class func initializeUserIDWithName(name: String) -> Void
    {
        var userDict = ["uuid":uuid]
        usersRef.setValue(userDict)
    }
    
    class func getAllPicturesForCurrentUser(withBlock:(NSMutableArray) -> ())
    {
        println("getting all pics for user")
        var pictureRef = rootRef.childByAppendingPath("pictures")
        pictureRef.queryOrderedByChild("owner").queryEqualToValue(uuid).observeEventType(FEventType.Value, withBlock: { snapshot in
            println("snapshot before check")
            if snapshot.value is NSNull
            {
                println("nsnull")
                return;
            }
            else
            {
            var snapVal: NSDictionary = snapshot.value as! NSDictionary
            var images: NSMutableArray = NSMutableArray()
            snapVal.enumerateKeysAndObjectsUsingBlock({ (key, value, stop) -> Void in
                let base64: String = value["base64"] as! String
                let event: String = value["event"] as! String
                let owner: String = value["owner"] as! String
                println("event: " + event + " owner: " + owner)
                var pic = Picture()
                
            
            })
            withBlock(images)
            }
            
           
        })
        
    }
}
