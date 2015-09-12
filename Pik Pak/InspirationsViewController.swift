//
//  InspirationsViewController.swift
//  Controllers: Contains InspirationsViewController.swift, a UICollectionViewController subclass that sets up the collection view in the same way UITableViewController does.
//

import UIKit

class InspirationsViewController: UICollectionViewController {
  
  let inspirations = Inspiration.allInspirations()
  let colors = UIColor.palette()
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView!.backgroundColor = UIColor.clearColor()
    
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: CGRectGetWidth(collectionView!.bounds), height: 100)
  }

}

extension InspirationsViewController {
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = inspirations.count
    return count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! UICollectionViewCell
    cell.contentView.backgroundColor = colors[indexPath.item]
    return cell
  }

}