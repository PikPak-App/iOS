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
    
    class func getUserInfo() -> Void
    {
        usersRef.observeEventType(.Value, withBlock: { snapshot in
            println(snapshot.value)
        })
    }

}
