//
//  PictureCollectionViewController.swift
//  Pik Pak
//
//  Created by Arpan Rughani on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit

class PictureCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBAction func ThumbsUp(sender: AnyObject) {
        
        
    }

    var imagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesArray = ["Dom", "ivan", "zack"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: imagesArray[indexPath.row])
        
        
        
        
        return cell
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return imagesArray.count
    }
    }


