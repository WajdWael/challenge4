//
//  Words.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 24/06/1446 AH.
//

import Foundation

// Word Model
struct Word: Identifiable {
    let id = UUID()
    let word: String
    let imageName: String
    let backgroundColor: String
    var isCompleted: Bool
}
