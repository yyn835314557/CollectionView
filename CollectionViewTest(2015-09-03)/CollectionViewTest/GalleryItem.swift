//
//  GalleryItem.swift
//  CollectionViewTest
//
//  Created by 游义男 on 15/9/3.
//  Copyright © 2015年 游义男. All rights reserved.
//

import Foundation

// model
class GalleryItem {
    
    var itemImage:String
    
    init(dataDictionary:Dictionary<String,String>) {
        itemImage = dataDictionary["itemImage"]!
    }
    
    class func newGalleryItem(dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }
    
}