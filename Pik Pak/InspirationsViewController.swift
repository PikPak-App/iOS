//
//  InspirationsViewController.swift
//  Controllers: Contains InspirationsViewController.swift, a UICollectionViewController subclass that sets up the collection view in the same way UITableViewController does.
//

import UIKit

class InspirationsViewController: UICollectionViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    var selectedEvent: String = ""
    
    //let inspirations = Inspiration.allInspirations()
    var allEvents: [Event] = [Event]()
    {
        didSet
        {
            collectionView!.reloadData()
            navBar.title = "Events"
        }
    }
    //an inspiration is basically an image and some text for the view. Use one of the event methods for this instead.
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func inspirationsFromAllEvents() -> [Inspiration]
    {
        var allInspirations: [Inspiration] = [Inspiration]()
        for event in allEvents
        {
            var inspire = Inspiration(title: event.name, speaker: "", room: "", time: "", backgroundImage: event.cover)
            allInspirations.append(inspire)
        }
        return allInspirations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Events.getAllEvents { (events) -> () in
            self.allEvents = events
            println(self.allEvents)
        }
        println("got all events")
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView!.backgroundColor = UIColor.clearColor()
        
        
    }
    
}

extension InspirationsViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = inspirationsFromAllEvents().count
        return count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let inspirations = inspirationsFromAllEvents()
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! InspirationCell
        cell.inspiration = inspirations[indexPath.item]
        
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = collectionViewLayout as! UltravisualLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
        println("Selected item")
        selectedEvent = allEvents[indexPath.row].id
        self.performSegueWithIdentifier("pushToPictureCollection", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pushToPictureCollection")
        {
            let vc: PictureCollectionViewController = segue.destinationViewController as! PictureCollectionViewController
            vc.eventID = selectedEvent
            
        }
        
    }
}