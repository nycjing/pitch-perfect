//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jing Jia on 4/11/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    
   var filePathUrl: NSURL?
    
   var title: String?
    
   init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
    
}
