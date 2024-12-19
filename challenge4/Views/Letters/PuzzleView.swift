//
//  PuzzleView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//
import SwiftUI

struct PuzzleView: View {
    @StateObject private var viewModel = PuzzleViewModel()
    
    var body: some View {
        VStack {
            // Full Puzzle Background Image
            ZStack {
                Image(viewModel.backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3) // 30% opacity
                    .frame(width: 965, height: 486)
                
                // Puzzle Grid with Tiles
                VStack(spacing: 2) {
                    ForEach(0..<viewModel.gridSize.rows, id: \.self) { row in
                        HStack(spacing: 2) {
                            ForEach(0..<viewModel.gridSize.columns, id: \.self) { col in
                                let piece = viewModel.grid[row][col]
                                ZStack {
                                    Color.clear
                                        .frame(width: 324, height: 240)
                                        .border(Color.black, width: 2)  // Black border
                                    
                                    if let piece = piece {
                                        Image(piece.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                .onTapGesture {
                                    if let selectedPiece = viewModel.tileList.first {
                                        viewModel.placeTile(selectedPiece, at: row, col: col)
                                    }
                                }
                            }
                        }
                    }
                }
            }
//            .frame(width: 30, height: 300)

            // Scrollable List of Tiles
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.tileList) { piece in
                        Image(piece.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .border(Color.black, width: 1)
                            .onTapGesture {
                                // User selects a tile to move
                                print("Selected \(piece.imageName)")
                            }
                    }
                }
            }
            .padding()
        }
    }
}


//struct PuzzleView: View {
//    @StateObject private var viewModel: PuzzleViewModel
//
//    // Initialize the view model with the puzzle model if it exists
//    init(puzzleModel: PuzzleModel? = nil) {
//        _viewModel = StateObject(wrappedValue: PuzzleViewModel(puzzleModel: puzzleModel))
//    }
//
//    var body: some View {
//        VStack {
//            // Full Puzzle Background Image
//            ZStack {
//                Image("puzzleA")  // Assume puzzleImage is the full image name
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .opacity(0.3)
//                    .frame(width: 965, height: 486)
//
//                // Puzzle Grid with Tiles
//                VStack(spacing: 2) {
//                    ForEach(0..<viewModel.gridSize, id: \.self) { row in
//                        HStack(spacing: 2) {
//                            ForEach(0..<viewModel.gridSize, id: \.self) { col in
//                                let piece = viewModel.grid[row][col]
//                                ZStack {
//                                    Color.clear
//                                        .frame(width: 320, height: 160)
//                                        .border(Color.black, width: 2)  // Black border
//
//                                    if let piece = piece {
//                                        Image(piece)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                    }
//                                }
//                                .onTapGesture {
//                                    if let selectedPiece = viewModel.tileList.first {
//                                        viewModel.placeTile(selectedPiece, at: row, col: col)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .frame(width: 300, height: 300)
//
//            // Scrollable List of Tiles
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(viewModel.tileList, id: \.self) { piece in
//                        Image(piece)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 80, height: 80)
//                            .border(Color.black, width: 2)
//                            .onTapGesture {
//                                // User selects a tile to move
//                                print("Selected \(piece)")
//                            }
//                    }
//                }
//            }
//            .padding()
//
//        }
//        .onAppear {
//            viewModel.setupPuzzle()
//        }
//    }
//}

#Preview {
    PuzzleView()
}
