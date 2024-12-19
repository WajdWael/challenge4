//
//  TutorialModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftData
import Foundation

@Model class TutorialModel {
    var id: UUID
    var videoURL: URL  // URL of the tutorial video
    var images: [String]  // List of tutorial image names or URLs
    var audioURL: URL    // URL of the tutorial's audio (voice)
    
    init(id: UUID, videoURL: URL, images: [String], audioURL: URL) {
        self.id = UUID()
        self.videoURL = videoURL
        self.images = images
        self.audioURL = audioURL
    }
}
