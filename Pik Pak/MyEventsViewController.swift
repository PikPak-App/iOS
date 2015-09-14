//
//  MyEventsViewController.swift
//  Pik Pak
//
//  Created by Andrew on 9/13/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit

class MyEventsViewController: UITableViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var eventTableView: UITableView!
    
    var event: Event = Event()
    let imagePicker = UIImagePickerController()
    var userEvents: [Event] = [Event]()
    {
        didSet
        {
            tableView.reloadData()
        }
    }
    
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        /*userEvents = Events.getEventsOwnedByUser({ eventsArray in
            let events = eventsArray
        })*/
        
        Events.getEventsOwnedByUser { (events) -> () in
            self.userEvents = events
        }
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
    }
    
    override func viewDidAppear(animated: Bool) {
        println("View did appear")
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("currentEvent")
        //NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func AddEventButtonPress(sender: AnyObject) {

        let alertController = UIAlertController(title: "Create a New Event", message: "Enter a name for the event. After, you will be prompted to take a picture to act as the cover photo for this event.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let nameTextField = alertController.textFields![0] as! UITextField
            
            self.event.name = nameTextField.text
            
            // show camera and get cover
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        }
        alertController.addAction(OKAction)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Event Name"
        }
        self.presentViewController(alertController, animated: true) {}
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.event.cover = pickedImage
            Events.createEvent(self.event)
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = eventTableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var titleLabel:UILabel = cell.viewWithTag(10) as! UILabel
        titleLabel.text = userEvents[indexPath.row].name as String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedID = userEvents[indexPath.row].id
        NSUserDefaults.standardUserDefaults().setObject(selectedID, forKey: "currentEvent")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
