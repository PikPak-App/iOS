//
//  Events.swift
//  Pik Pak
//
//  Created by Loic Sharma on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import UIKit

class Events {
    
    static var rootRef = Firebase(url: "https://pikapic.firebaseio.com/")
    static var eventsRef = rootRef.childByAppendingPath("events")
    
    class func createEvent(event: Event) {
        //var imageData: NSData = UIImagePNGRepresentation(event.cover)
        
        var eventDict = ["name": event.name, "location": ["lat":event.location.coordinate.latitude,"long":event.location.coordinate.longitude]/*, "cover": imageData.base64EncodedDataWithOptions(.allZeros)*/]
        eventsRef.childByAutoId().setValue(eventDict)
    }
    
    class func getEvent(id: String)
    {
        var eventRef = eventsRef.childByAppendingPath(id)
        eventRef.observeEventType(.Value, withBlock: { snapshot in
            println(snapshot.value)
        }, withCancelBlock: {error in
            println(error.description)
        })
        
    }
    
    func relevantEventsForLocation(location: CLLocation) -> [Event] {
        return [];
    }
    
    func picturesForEvent(event: Event) -> [Picture] {
        return [];
    }
}