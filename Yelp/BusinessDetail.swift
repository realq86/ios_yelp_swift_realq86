//
//  BusinessDetail.swift
//  Yelp
//
//  Created by Developer on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessDetail: NSObject {
    
    var imageURL:URL?
    
    var phoneNumber:String?
    
    var snippetText:String?
    init(dictionary:NSDictionary) {
        
        
        self.imageURL = nil
        if let imageURLString = dictionary["image_url"] as? String {
            self.imageURL = URL(string: imageURLString)
        }
        
        self.phoneNumber = ""
        if let phoneNumberString = dictionary["display_phone"] as? String {
            self.phoneNumber = phoneNumberString
        }
        
        self.snippetText = ""
        if let snippetString = dictionary["snippet_text"] as? String {
            self.snippetText = snippetString
        }
    }
    
    

}
