//
//  PictureCollectionViewController.swift
//  Pik Pak
//
//  Created by Arpan Rughani on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit

class PictureCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBAction func ThumbsUp(sender: AnyObject) {
        
    }


    
    let imagePicker = UIImagePickerController()
    var eventID: String = ""
    //This is always null, so it always gets and sends null pictures for every event!
    var pictures: [Picture] = [Picture]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotif:", name: "EventChangeNotif", object: nil)
        // Do any additional setup after loading the view.
    }
    
    func receiveNotif(notification:NSNotification)
    {
        println("Notification received")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Events.getEvent(eventID, withBlock: { event in
            println("event title" + event.name)
        })
        Events.picturesForEvent(eventID, withBlock: { (pics) -> () in
            self.pictures = pics
            self.collectionView!.reloadData()
        })
        //eventID = NSUserDefaults.standardUserDefaults().objectForKey("currentEvent") as! String
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("currentEvent")
        //NSUserDefaults.standardUserDefaults().synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            println("current event id " + eventID)
            Pictures.sendPictureToEvent(pickedImage, eventID: eventID)
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = pictures[indexPath.row].image
        
        return cell

    }
    
    @IBAction func captureImageBtn(sender: AnyObject) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return pictures.count;
    }
    }


