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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Users.getUserInfo()
        var event: Event = Event()
        event.name = "MHacks"
        //event.cover = UIImage()
        event.location = CLLocation(latitude: 20, longitude: 10)
        Events.createEvent(event)
        //Events.getEvent("");
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

