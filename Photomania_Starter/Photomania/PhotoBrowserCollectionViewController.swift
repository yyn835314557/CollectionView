//
//  PhotoBrowserCollectionViewController.swift
//  Photomania
//
//  Created by Essan Parto on 2014-08-20.
//  Copyright (c) 2014 Essan Parto. All rights reserved.
//

import UIKit
import Alamofire

class PhotoBrowserCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var photos = NSMutableOrderedSet()
    
    var isPopulatingPhoto = false
    var currentPage = 1
  
    let refreshControl = UIRefreshControl()
  
    let PhotoBrowserCellIdentifier = "PhotoBrowserCell"
    let PhotoBrowserFooterViewIdentifier = "PhotoBrowserFooterView"
  
  // MARK: Life-cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatingPhoto()
    
////    Alamofire.request(Method.GET, "https://api.500px.com/v1/photos").responseJSON { (_, _, data, _) -> Void in
////        println(data!)
////    }
//    Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters: ["consumer_key":"2nLJOm0Lv33m7swnnDM5cbWjpJknPYmL1y9quhhO"]).responseJSON { (req, _, json, _) -> Void in
//        //API地址
////        println(req.URLString)
////        println(json!)
//        if let j = json as? NSDictionary{
//            var safePhotos = j.valueForKey("photos") as! [NSDictionary]
//            
//            //筛选出安全图片 filter
//            safePhotos = safePhotos.filter{
//                $0["nsfw"] as! Bool == false
//            }
//            let newPhotos = safePhotos.map({
//                PhotoInfo(id: $0["id"] as! Int, url: $0["image_url"] as! String)
//            })
//            self.photos.addObjectsFromArray(newPhotos)
//            self.collectionView?.reloadData()
//        }
//    }
    
    setupView()

  }
    
    func populatingPhoto(){
        if isPopulatingPhoto{
            return
        }
        isPopulatingPhoto = true
        Alamofire.request(Five100px.Router.Popular(currentPage)).responseJSON { (_, _, json, _) -> Void in
            if let j = json as? NSDictionary  {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                    let newPhotos = (j.valueForKey("photos") as! [NSDictionary]).filter{$0["nsfw"] as! Bool == false}.map{
                        PhotoInfo(id: $0["id"] as! Int, url: $0["image_url"] as! String)
                    }
                    
                    let lastItem = self.photos.count
                    self.photos.addObjectsFromArray(newPhotos)
                    let indexPaths = (lastItem..<self.photos.count).map{
                        NSIndexPath(forItem: $0, inSection: 0)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.collectionView!.insertItemsAtIndexPaths(indexPaths)
                        
                    })
                })
            }
            self.currentPage++
        }
        isPopulatingPhoto = false
    }
  
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y + view.frame.height > scrollView.contentSize.height * 0.8 {
            populatingPhoto()
        }
    }
    
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: CollectionView
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionViewCell
    
    let photo = self.photos.objectAtIndex(indexPath.row) as! PhotoInfo
    let imgurl = photo.url
//    Alamofire.request(.GET, imgurl).response { (_, _, data, _) -> Void in
//        if let d = data {
//            cell.imageView.image = UIImage(data: d)
//        }
//    }
    //解决网络延迟，解决方法
    cell.imageView.image = nil
    cell.request = Alamofire.request(.GET,imgurl).responseImageJSON { (req, _, image, _) -> Void in
        if let img: AnyObject = image {
            if req.URLString == cell.request?.request.URLString{
                cell.imageView.image = img as? UIImage

            }
        }
    }
    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoBrowserFooterViewIdentifier, forIndexPath: indexPath) as! UICollectionReusableView
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowPhoto", sender: (self.photos.objectAtIndex(indexPath.item) as! PhotoInfo).id)
  }
  
  // MARK: Helper
  
  func setupView() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    
    let layout = UICollectionViewFlowLayout()
    let itemWidth = (view.bounds.size.width - 2) / 3
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    layout.minimumInteritemSpacing = 1.0
    layout.minimumLineSpacing = 1.0
    layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
    
    collectionView!.collectionViewLayout = layout
    
    let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
    titleLabel.text = "Photomania"
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    navigationItem.titleView = titleLabel
    
    collectionView!.registerClass(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCellIdentifier)
    collectionView!.registerClass(PhotoBrowserCollectionViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoBrowserFooterViewIdentifier)
    
    refreshControl.tintColor = UIColor.whiteColor()
    refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
    collectionView!.addSubview(refreshControl)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowPhoto" {
      (segue.destinationViewController as! PhotoViewerViewController).photoID = sender!.integerValue
      (segue.destinationViewController as! PhotoViewerViewController).hidesBottomBarWhenPushed = true
    }
  }
  
  func handleRefresh() {
    
  }
}

class PhotoBrowserCollectionViewCell: UICollectionViewCell {
  let imageView = UIImageView()
    var request: Alamofire.Request?
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    
    imageView.frame = bounds
    addSubview(imageView)
  }
}

class PhotoBrowserCollectionViewLoadingCell: UICollectionReusableView {
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    spinner.startAnimating()
    spinner.center = self.center
    addSubview(spinner)
  }
}
