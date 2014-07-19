//
//  TLSPost.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

class TLSPost: NSObject {
    
    var author: NSString = "";
    var createdAt: NSDate = NSDate.date();
    var content:NSString = ""
    
    init(author:NSString, content:NSString) {
        super.init()
        self.createdAt = NSDate.date()
        self.author = author
        self.content = content
    }
   
}
