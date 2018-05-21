//
//  ViewController.swift
//  GCDAsyncImage
//
//  Created by Chase Wang on 2/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numberOfCells = 20_000
    var imageWithFilter: UIImage?
    let imageURLArray = Unsplash.defaultImageURLs
    var data: Data?
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func cancelDownload(cancelQueue: DispatchQueue) {
        cancelQueue.suspend()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.cancelDownload(cancelQueue: <#T##DispatchQueue#>)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
        
        let url = imageURLArray[indexPath.row % imageURLArray.count]
//        finished smooth scrolling by downloading img data using background queue
        let downloadQueue = DispatchQueue(label: "download", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        downloadQueue.async {
            self.data = try? Data(contentsOf: url)
            if let imgData = self.data {

                    let image = UIImage(data: imgData)
                    // TODO: add sepia filter to image
                    let inputImage = CIImage(data: UIImagePNGRepresentation(image!)!)
                    let filter = CIFilter(name: "CISepiaTone")!
                    filter.setValue(inputImage, forKey: kCIInputImageKey)
                    filter.setValue(0.8, forKey: kCIInputIntensityKey)
                    let outputCIImage = filter.outputImage
                    self.imageWithFilter = UIImage(ciImage: outputCIImage!)
                    DispatchQueue.main.async {
                        cell.pictureImageView.image = self.imageWithFilter
                    }
                }
        }
        
//        if let imgData = self.data {
//            let image = UIImage(data: imgData)
//            // TODO: add sepia filter to image
//            let inputImage = CIImage(data: UIImagePNGRepresentation(image!)!)
//            let filter = CIFilter(name: "CISepiaTone")!
//            filter.setValue(inputImage, forKey: kCIInputImageKey)
//            filter.setValue(0.8, forKey: kCIInputIntensityKey)
//            let outputCIImage = filter.outputImage
//            self.imageWithFilter = UIImage(ciImage: outputCIImage!)
//            //        first download image, than add filter to the image
//
//        }
        
//        if let filter = self.imageWithFilter {
//            DispatchQueue.main.async {
//                cell.pictureImageView.image = filter
//            }
//        }
        
        
        
        
        return cell
    }
    
}
