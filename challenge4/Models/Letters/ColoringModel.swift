//
//  ColoringModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import Foundation
import SwiftData

@Model class ColoringModel {
    var id: UUID
    var canvasImage: String  // The canvas image name or URL
    var chalks: [String]     // List of chalk color names
    var isCompleted: Bool     // Whether coloring is done or not
    
    init(id: UUID, canvasImage: String, chalks: [String], isCompleted: Bool) {
        self.id = id
        self.canvasImage = canvasImage
        self.chalks = chalks
        self.isCompleted = isCompleted
    }
}
