//
//  Letter.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 24/06/1446 AH.
//

import Foundation

struct Letter: Identifiable {
    let id = UUID()
    let letter: String
    let coloringCanvas: String
    let puzzleImage: String
    let videoTutorial: String
    var isCompleted: Bool
}
