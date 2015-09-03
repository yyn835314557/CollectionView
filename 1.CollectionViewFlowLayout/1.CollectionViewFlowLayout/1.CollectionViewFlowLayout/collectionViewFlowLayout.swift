////
////  collectionViewFlowLayout.swift
////  1.CollectionViewFlowLayout
////
////  Created by 游义男 on 15/9/2.
////  Copyright (c) 2015年 游义男. All rights reserved.
////
//
//import UIKit
//
//class collectionViewFlowLayout: UICollectionViewFlowLayout {
//    var sectionAttributes:[(header:UICollectionViewLayoutAttributes!,sectionEnd:CGFloat!)] = []
//    let offsets = NSMutableOrderedSet()
//    var floatingSectionIndex:Int! = nil
//    var width:CGFloat! = nil
//    
//    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
//        return true
//    }
//    
//    // 什么意思
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        let attrs = super.layoutAttributesForElementsInRect(rect)
//        let ret = attrs?.map({ (attribute) -> UICollectionViewLayoutAttributes in
//            let attr:(UICollectionViewLayoutAttributes) = attribute as! (UICollectionViewLayoutAttributes)
//            if let elementKind = attr.representedElementKind {
//                if (elementKind == UICollectionElementKindSectionHeader){
//                    return self.sectionAttributes[attr.indexPath.section].header
//                }
//            }
//            return attr
//        })
//        return ret
//    }
//
//    private func indexForOffset(offset: CGFloat) -> Int {
//        
//        let range = NSRange(location:0, length:self.offsets.count)
//        return self.offsets.indexOfObject(offset,
//            inSortedRange: range,
//            options: .InsertionIndex,
//            usingComparator: { (section0:AnyObject!, section1:AnyObject!) -> NSComparisonResult in
//                let s0:CGFloat = section0 as! CGFloat
//                let s1:CGFloat = section1 as! CGFloat
//                return s0 < s1 ? .OrderedAscending : .OrderedDescending
//        })
//    }
//}
