//
//  UIImageViewAsync.swift
//  LookInDay
//
//  Created by Denis Nascimento on 6/15/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

import UIKit
import Foundation

class UIImageViewAsync: UIImageView {

  override init(frame:CGRect)
  {
    super.init(frame:frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
      completion(data: NSData(data: data))
      }.resume()
  }
  
  func downloadImage(url:String){
    getDataFromUrl(url) { data in
      dispatch_async(dispatch_get_main_queue()) {
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.image = UIImage(data: data!)
      }
    }
  }

}
