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
class PinterestLayout: UICollectionViewLayout ,PinterestLayoutDelegate{
  
  //1 reference
  var delegate:PinterestLayoutDelegate
  //2 定义了一行放置两个item
  var numberOfColumns = 2
  var cellPadding:CGFloat = 6.0
  //3 When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
  private var cache = [UICollectionViewLayoutAttributes]()
  //4
  private var contentHeight:CGFloat = 0.0
  private var contentWidth:CGFloat {
  let insets = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
  }
  
  /**
  primary objective is to calculate an instance of UICollectionViewLayoutAttributes for every item in the layout
  */
  override func prepareLayout() {
    // only calculate once item Frame
    if cache.isEmpty{
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns{
        xOffset.append(CGFloat(column) * columnWidth )
      }
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      //3
    }
  }
}
