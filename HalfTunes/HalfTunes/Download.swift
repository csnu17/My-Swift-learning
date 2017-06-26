//
//  Download.swift
//  HalfTunes
//
//  Created by Phetrungnapha, K. on 6/26/2560 BE.
//  Copyright © 2560 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  
  var track: Track
  
  init(track: Track) {
    self.track = track
  }
  
  var task: URLSessionDownloadTask?
  var isDownloading = false
  var resumeData: Data?
  
  var progress: Float = 0
  
}
