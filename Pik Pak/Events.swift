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
    
    static let rootRef = Firebase(url: "https://pikapic.firebaseio.com/")
    static let eventsRef = rootRef.childByAppendingPath("events")
    static let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
    
    class func createEvent(event: Event) {
        var imageData: NSData = UIImageJPEGRepresentation(event.cover, 0.25)
        var imageString: NSString = imageData.base64EncodedStringWithOptions(.allZeros)
        var eventRef = eventsRef.childByAutoId()
        var eventDict = ["name": event.name, "location": ["lat":event.location.coordinate.latitude,"long":event.location.coordinate.longitude],"owner":uuid,"cover":imageString]
        eventRef.setValue(eventDict)
    }
    
    class func getEvent(id: String, withBlock: (Event) -> ())
    {
        var eventRef = eventsRef.childByAppendingPath(id)
        var snapshotVal: NSDictionary = NSDictionary()
        eventRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            println(snapshot.value)
            var event = Event()
            println(snapshotVal)
            snapshotVal = snapshot.value as! NSDictionary
            event.id = id
            event.name = snapshotVal["name"] as! String
            var location: NSDictionary = snapshotVal["location"] as! NSDictionary
            var lat: Double = location["lat"] as! Double
            var long: Double = location["long"] as! Double
            println("id: " + event.id)
            event.location = CLLocation(latitude: lat, longitude: long)
            withBlock(event)
            }, withCancelBlock: {error in
                println(error.description)
        })
    }
    
    /*func relevantEventsForLocation(location: CLLocation, withBlock: ([Event]) -> ()) {
        let root = Firebase(url: "https://pikapic.firebaseio.com")
        let geoFire = GeoFire(firebaseRef: root)
        
        var circleQuery = geoFire.queryAtLocation(location, withRadius: 0.6)
        
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        var query = geoFire.queryWithRegion(region)
        
        var keys = Array<String>()
        var events = Array<Event>()
        
        query.observeEventType(GFEventTypeKeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            keys.append(key)
        })
        
        query.observeReadyWithBlock({
            query.removeAllObservers()
            
            // TODO convert keys into events.
            // Call withBlock
            
            withBlock(events)
            
        })
    }*/
    
    class func picturesForEvent(eventID: String, withBlock:([Picture]) -> ()) {
        let pictureRef = rootRef.childByAppendingPath("pictures")
        pictureRef.queryOrderedByChild("event").queryEqualToValue(eventID).observeEventType(FEventType.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull
            {
                return;
            }
            var snapVal: NSDictionary = snapshot.value as! NSDictionary
            var images = [Picture]()
            snapVal.enumerateKeysAndObjectsUsingBlock({ (key, value, stop) -> Void in //key is string of id and value is dict of values
                let id: String = key as! String
                let base64: String = value["base64"] as! String
                let event = value["event"]
                let score = value["score"]
                var image: Picture = Picture()
                image.id = id as String
                images.sort({ $0.score < $1.score })
                let base64data: NSData! = NSData(base64EncodedString: base64, options: nil)
                image.image = UIImage(data: base64data)
                images.append(image)
            })
            
            withBlock(images)
        })
    }
    
    class func getAllEvents(withBlock:([Event]) -> ()) {
        eventsRef.observeEventType(.Value, withBlock: { snapshot in
            if(snapshot.value is NSNull)
            {
                return;
            }
            var snapVal: NSDictionary = snapshot.value as! NSDictionary
            var events = [Event]()
            snapVal.enumerateKeysAndObjectsUsingBlock({ (key, value, stop) -> Void in //key is string of id and value is dict of values
                var event:Event = Event()
                event.id = key as! String
                event.name = value["name"] as! String
                event.owner = value["owner"] as! String
                var base64 = value["cover"] as! String
                let base64data: NSData! = NSData(base64EncodedString: base64, options: nil)
                event.cover = UIImage(data: base64data)
                //decode picture
                
                events.append(event)
            })
            withBlock(events)
        })
    }
    
    class func getEventsOwnedByUser(withBlock:([Event]) -> ())
    {
        eventsRef.queryOrderedByChild("owner").queryEqualToValue(uuid).observeEventType(.Value, withBlock: { snapshot in
        if(snapshot.value is NSNull)
        {
            return;
        }
        var snapVal: NSDictionary = snapshot.value as! NSDictionary
        var events = [Event]()
        println(snapVal)
            snapVal.enumerateKeysAndObjectsUsingBlock({ (key, value, stop) -> Void in //key is string of id and value is dict of values
                var event:Event = Event()
                event.id = key as! String
                event.name = value["name"] as! String
                event.owner = value["owner"] as! String
                var base64 = value["cover"] as! String
                let base64data: NSData! = NSData(base64EncodedString: base64, options: nil)
                event.cover = UIImage(data: base64data)
                //decode picture
                
            events.append(event)
            })
        withBlock(events)
        })
    }
    
    class func shittyGetEventsOwnedByUser() -> NSMutableArray
    {
        if(NSUserDefaults.standardUserDefaults().objectForKey("myEvents") == nil)
        {
            var events: NSMutableArray = NSMutableArray()
            NSUserDefaults.standardUserDefaults().setObject(events, forKey: "myEvents")
            NSUserDefaults.standardUserDefaults().synchronize()
            return events
        }
        else
        {
            var eventDicts: NSMutableArray = NSUserDefaults.standardUserDefaults().objectForKey("myEvents") as! NSMutableArray
            return eventDicts
        }
    }
    
}