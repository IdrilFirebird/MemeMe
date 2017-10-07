    //
//  Meme.swift
//  MemeMe
//
//  Created by Sebastian on 04.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import Foundation
import UIKit
    
struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    init(topText: String, bottomText:String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    
  
    
}
