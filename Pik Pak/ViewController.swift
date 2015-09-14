//
//  ViewController.swift
//  Pik Pak
//
//  Created by Loic Sharma on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var imageViewer: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var currentEvent: Event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((NSUserDefaults.standardUserDefaults().objectForKey("firstRun")) == nil)
        {
            Users.initializeUserIDWithName("test name")
        }
        NSUserDefaults.standardUserDefaults().removeObjectForKey("currentEvent")
        NSUserDefaults.standardUserDefaults().synchronize()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        Users.getUserInfo()
        var event: Event = Event()
        event.name = "Cup Stacking"
        //event.cover = UIImage()
        event.location = CLLocation(latitude: 20, longitude: 10)
        Events.createEvent(event)
        Events.getEvent("-Jz3M1W8wa_l9SVQEShi",withBlock: { event in
            println("event id " + event.id)
            self.currentEvent = event
            self.eventNameLabel.text = self.currentEvent.name;
        })
        Events.picturesForEvent("-Jz3M1W8wa_l9SVQEShi", withBlock: { images in
            let pic:Picture = images[0]
            self.imageViewer.image = pic.image
        })
        //Events.getEvent("");
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func receiveEventsNotif(notification: NSNotification)
    {
        println(notification.object)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            println("current event id " + currentEvent.id)
            Pictures.sendPictureToEvent(pickedImage, eventID: currentEvent.id)
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func PictureButton(sender: AnyObject) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

