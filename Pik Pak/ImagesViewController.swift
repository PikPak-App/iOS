//
//  ImagesViewController.swift
//  Pik Pak
//
//  Created by Arpan Rughani on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionview: UICollectionView!
    
    struct country
    {
        var country:String
        var code:String
        init(code:String, country:String)
        {
            self.country = country
            self.code = code
        }
    }
    
    var Data:Array<  country > = Array < country >()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:1,left:10,bottom:10,right:10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        
        collectionview.collectionViewLayout = layout
        
        get_data_from_url("http://www.kaleidosblog.com/tutorial/tutorial.json")
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        
        var bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        
        cell.layer.borderColor = bcolor.CGColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        
        cell.backgroundColor=UIColor.whiteColor()
        
        
        cell.text.text = Data[indexPath.row].code
        cell.country.text = Data[indexPath.row].country
        
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return Data.count
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return CGSize(width: 100  , height: 50)
            
    }
    
    
    
    func extract_json(data:NSString)
    {
        var parseError: NSError?
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &parseError)
        if (parseError == nil)
        {
            if let countries_list = json as? NSArray
            {
                for (var i = 0; i < countries_list.count ; i++ )
                {
                    if let country_obj = countries_list[i] as? NSDictionary
                    {
                        if let country_name = country_obj["country"] as? String
                        {
                            if let country_code = country_obj["code"] as? String
                            {
                                var add_it = country(code: country_code, country: country_name)
                                Data.append(add_it)
                            }
                        }
                    }
                }
            }
        }
        do_refresh();
    }
    
    
    func do_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionview.reloadData()
            return
        })
    }
    
    func get_data_from_url(url:String)
    {
        let httpMethod = "GET"
        let timeout = 15
        let url = NSURL(string: url)
        let urlRequest = NSMutableURLRequest(URL: url!,
            cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 15.0)
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(
            urlRequest,
            queue: queue,
            completionHandler: {(response: NSURLResponse!,
                data: NSData!,
                error: NSError!) in
                if data != nil && error == nil{
                    let json = NSString(data: data, encoding: NSASCIIStringEncoding)
                    self.extract_json(json!)
                }
            }
        )
    }
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headersection", forIndexPath: indexPath) as! UICollectionReusableView
        
        
        
        return header
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50.0)
        
        
    }
    
}
