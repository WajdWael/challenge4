import SwiftUI
import Foundation

class PuzzleViewModel: ObservableObject {
    @Published var gridSize: (rows: Int, columns: Int) = (2, 3)  // 2 rows and 3 columns
    @Published var grid: [[PuzzlePiece?]] = []
    @Published var tileList: [PuzzlePiece] = []
    
    let backgroundImage = "puzzleA"  // Full puzzle image name

    init() {
        setupPuzzle()
    }

    func setupPuzzle() {
        grid = Array(repeating: Array(repeating: nil, count: gridSize.columns), count: gridSize.rows)
        
        // Create 6 puzzle pieces for a 2x3 grid
        tileList = (0..<6).map { index in
            PuzzlePiece(imageName: "tile\(index + 1)", position: (row: -1, col: -1))
        }
    }

    func placeTile(_ piece: PuzzlePiece, at row: Int, col: Int) {
        if grid[row][col] == nil {
            // Remove the piece from the scrollable list
            if let index = tileList.firstIndex(of: piece) {
                tileList.remove(at: index)
            }
            // Place piece in the grid
            grid[row][col] = piece
        }
    }
}

struct PuzzlePiece: Identifiable, Equatable {
    var id = UUID()
    var imageName: String
    var position: (row: Int, col: Int)  // To track where the piece is placed in the grid
    
    // Implementing the == function for Equatable conformance
    static func == (lhs: PuzzlePiece, rhs: PuzzlePiece) -> Bool {
        return lhs.id == rhs.id && lhs.imageName == rhs.imageName
    }
}
