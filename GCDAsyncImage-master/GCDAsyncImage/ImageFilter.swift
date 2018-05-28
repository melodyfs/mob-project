//
//  ImageFilter.swift
//  GCDAsyncImage
//
//  Created by Sky Xu on 5/28/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

class ImageFilter: Operation {
    let photoRecord: PhotoRecord
    
    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        if self.photoRecord.state != .Downloaded {
            return
        }
        
        if let rawImage = self.photoRecord.image {
            let inputImage = CIImage(data: UIImagePNGRepresentation(rawImage)!)
            let filter = CIFilter(name: "CISepiaTone")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(0.8, forKey: kCIInputIntensityKey)
            let outputCIImage = filter.outputImage
            let filterImg = UIImage(ciImage: outputCIImage!)
            self.photoRecord.state = .Filtered
            self.photoRecord.image = filterImg
        }
    }
}
