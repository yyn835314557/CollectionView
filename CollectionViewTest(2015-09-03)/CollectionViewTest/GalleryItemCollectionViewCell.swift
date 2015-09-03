//
//  GalleryItemCollectionViewCell.swift
//  CollectionViewTest
//
//  Created by 游义男 on 15/9/3.
//  Copyright © 2015年 游义男. All rights reserved.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    
    func setGalleryItem(item:GalleryItem) {
        itemImageView.image = UIImage(named: item.itemImage)
    }
}
