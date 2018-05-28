//
//  PhotoRecord.swift
//  GCDAsyncImage
//
//  Created by Sky Xu on 5/28/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

// This enum contains all the possible states a photo record can be in
enum PhotoRecordState {
    case New, Downloaded, Filtered, Failed
}

class PhotoRecord {
    let url:URL
    var state = PhotoRecordState.New
    var image = UIImage(named: "Placeholder")
    
    init(url:URL) {
        self.url = url
    }
}
