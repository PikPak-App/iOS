//
//  Picture.swift
//  Pik Pak
//
//  Created by Loic Sharma on 9/12/15.
//  Copyright (c) 2015 Pik Pak. All rights reserved.
//

import Foundation
import UIKit

struct Picture {
    var id: String
    var score: Int
    var image: UIImage?
    
    init()
    {
        id = ""
        score = 0
    }
}