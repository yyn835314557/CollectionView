//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by 游义男 on 15/9/2.
//  Copyright (c) 2015年 Razeware LLC. All rights reserved.
//

// 为什么y 是固定的
import UIKit

/**
*  获取cell的height
*/
protocol PinterestLayoutDelegate{
  // 1 fetch image height
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
    withWidth:CGFloat) -> CGFloat
  // 2 fetch Annotation width
  func collectionView(collectionView: UICollectionView,
    heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
  
  // 1
  var photoHeight: CGFloat = 0.0
  
  // 2
  override func copyWithZone(zone: NSZone) -> AnyObject {
    let copy = super.copyWithZone(zone) as! PinterestLayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  // 3
  override func isEqual(object: AnyObject?) -> Bool {
    if let attributes = object as? PinterestLayoutAttributes {
      if( attributes.photoHeight == photoHeight  ) {
        return super.isEqual(object)
      }
    }
    return false
  }
}

class PinterestLayout:UICollectionViewLayout{
  
  //1 reference layout delegate
  var delegate:PinterestLayoutDelegate!
  //2 定义了一行放置两个item
  var numberOfColumns = 2
  var cellPadding:CGFloat = 6.0
  //3 When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
  private var cache = [PinterestLayoutAttributes]()
  //4
  private var contentHeight:CGFloat = 0.0
  private var contentWidth:CGFloat {
  let insets = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
  }
  
  override class func layoutAttributesClass() -> AnyClass {
    return PinterestLayoutAttributes.self
  }
  
  /**
  primary objective is to calculate an instance of UICollectionViewLayoutAttributes for every item in the layout
  */
  override func prepareLayout() {
    // only calculate once item Frame
    if cache.isEmpty{
      //2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns{
        xOffset.append(CGFloat(column) * columnWidth )
      }
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      //3
      for item in 0 ..< collectionView!.numberOfItemsInSection(0){
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        //4
        let width = columnWidth - cellPadding * 2
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height = cellPadding + photoHeight + annotationHeight + cellPadding
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
        //5
        let attributes = PinterestLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.photoHeight = photoHeight
        attributes.frame = insetFrame
        cache.append(attributes)
        //6
        contentHeight = max(contentHeight,CGRectGetMaxY(frame))
        yOffset[column] = yOffset[column] + height
        column = column >= (numberOfColumns - 1) ? 0 : ++column
      }
    }
  }
  
  /**
  *  collectionViewContentSize
  */
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in cache {
      if CGRectIntersectsRect(attributes.frame, rect){
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
   }
}
