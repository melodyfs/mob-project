//
//  ImageDownloader.swift
//  GCDAsyncImage
//
//  Created by Sky Xu on 5/28/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader: Operation {
    let photoRecord: PhotoRecord
    
    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        do {
            if let imageData = try? Data(contentsOf: self.photoRecord.url){
                self.photoRecord.image = UIImage(data: imageData)
                self.photoRecord.state = .Downloaded
            }
        } catch let err{
            print(err)
            self.photoRecord.state = .Failed
            self.photoRecord.image = UIImage(named: "Failed")
        }
        
    }
}
