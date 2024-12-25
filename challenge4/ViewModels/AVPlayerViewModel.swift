//
//  File.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 24/06/1446 AH.
//

import AVKit
import SwiftUI

class AVPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer

    init(url: URL) {
        self.player = AVPlayer(url: url)
    }
}
