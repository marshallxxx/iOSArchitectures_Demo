//
//  UIImage+Category.swift
//  Contacts
//
//  Created by Ion Brumari on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response, data, error) -> Void in
                self.image = UIImage(data: data!)
            }
        }
    }
}