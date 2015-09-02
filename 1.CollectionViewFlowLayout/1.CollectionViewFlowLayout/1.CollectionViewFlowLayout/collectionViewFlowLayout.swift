//
//  collectionViewFlowLayout.swift
//  1.CollectionViewFlowLayout
//
//  Created by 游义男 on 15/9/2.
//  Copyright (c) 2015年 游义男. All rights reserved.
//

import UIKit

class collectionViewFlowLayout: UICollectionViewFlowLayout {
    var sectionAttributes:[(header:UICollectionViewLayoutAttributes!,sectionEnd:CGFloat!)] = []
    let offsets = NSMutableOrderedSet()
    var floatingSectionIndex:Int! = nil
    var width:CGFloat! = nil
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    
}
