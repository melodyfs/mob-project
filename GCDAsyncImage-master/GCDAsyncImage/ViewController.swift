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
    
    var photos = [PhotoRecord]()
    let pendingOperations = PendingOperations()
    @IBOutlet weak var tableView: UITableView!
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    func startDownload(photoRecord: PhotoRecord, indexPath: IndexPath) {
        if let downloadOperation = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoRecord)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
//            if finish download, remove inprogress value from dict
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
//        add operation queue
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
        
    }
    
    func startFilter(photoRecord: PhotoRecord, indexPath: IndexPath) {
        if let filterOperation = pendingOperations.filtrationsInProgress[indexPath] {
            return
        }
        let filter = ImageFilter(photoRecord: photoRecord)
        filter.completionBlock = {
            if filter.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.filtrationsInProgress[indexPath] = filter
        pendingOperations.filtrationQueue.addOperation(filter)
    }
    
    func startOperationsForPhotoRecord(photoRecord: PhotoRecord, indexPath: IndexPath) {
        switch(photoRecord.state){
        case .New:
            startDownload(photoRecord: photoRecord, indexPath: indexPath)
        case .Downloaded:
            startFilter(photoRecord: photoRecord, indexPath: indexPath)
        default:
            NSLog("do nothing")
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
//        self.operation.cancelAllOperations()
//        cell.imageView?.image = nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
        let url = imageURLArray[indexPath.row % imageURLArray.count]
        
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            cell.accessoryView = indicator
        }
        
        let indicator = cell.accessoryView as! UIActivityIndicatorView
//        append urls to photorecord
        let photoRecord = PhotoRecord(url: url)
        self.photos.append(photoRecord)
        
        cell.imageView?.image = photoRecord.image
        
        switch(photoRecord.state) {
        case .Filtered:
            indicator.stopAnimating()
        case .Failed:
            indicator.stopAnimating()
        case .New, .Downloaded:
            indicator.startAnimating()
            self.startOperationsForPhotoRecord(photoRecord: photoRecord, indexPath: indexPath)
        }
        
        return cell
    }
    
}
