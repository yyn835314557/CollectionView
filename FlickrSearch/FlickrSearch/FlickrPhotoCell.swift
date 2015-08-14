//
//  FlickrPhotoCell.swift
//  FlickrSearch
//
//  Created by 游义男 on 15/8/14.
//  Copyright (c) 2015年 游义男. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selected = false
    }
    
    override var selected: Bool {
        didSet{
            self.backgroundColor = selected ? themeColor :UIColor.blackColor()
        }
    }
}
