import SwiftUI

// MARK: - PuzzlePiece Model
struct PuzzlePiece: Identifiable {
    var id = UUID()
    var image: Image
    var correctPosition: CGPoint
    var currentPosition: CGPoint
}

// MARK: - PuzzlePieceView
struct PuzzlePieceView: View {
    @State var piece: PuzzlePiece
    let pieceWidth: CGFloat
    let pieceHeight: CGFloat
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        piece.image
            .resizable()
            .frame(width: pieceWidth, height: pieceHeight)
            .position(x: piece.currentPosition.x + dragOffset.width,
                      y: piece.currentPosition.y + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        piece.currentPosition.x += value.translation.width
                        piece.currentPosition.y += value.translation.height
                        checkIfInCorrectPosition()
                    }
            )
    }

    func checkIfInCorrectPosition() {
        if abs(piece.currentPosition.x - piece.correctPosition.x) < pieceWidth / 2 &&
            abs(piece.currentPosition.y - piece.correctPosition.y) < pieceHeight / 2 {
            piece.currentPosition = piece.correctPosition
        }
    }
}

// MARK: - PuzzleView
struct PuzzleView: View {
    @State private var pieces: [PuzzlePiece] = []
    @State private var isCompleted: Bool = false
    let pieceWidth: CGFloat = 317
    let pieceHeight: CGFloat = 242
    let rows = 2 // Two rows
    let cols = 3 // Three columns

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    // Background reference image with low opacity
                    if let referenceImage = UIImage(named: "2") {
                        Image(uiImage: referenceImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: pieceWidth * CGFloat(cols), height: pieceHeight * CGFloat(rows))
                            .opacity(0.2)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 3)
                    }

                    // Puzzle Pieces
                    ForEach(pieces) { piece in
                        PuzzlePieceView(piece: piece, pieceWidth: pieceWidth, pieceHeight: pieceHeight)
                            .offset(x: geometry.size.width / 2 - pieceWidth * CGFloat(cols) / 2,
                                    y: geometry.size.height / 3 - pieceHeight * CGFloat(rows) / 2)
                    }
                }

                // Scrollable Row for Puzzle Pieces
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) {
                        ForEach(pieces) { piece in
                            piece.image
                                .resizable()
                                .frame(width: pieceWidth, height: pieceHeight)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                setupPuzzle(screenSize: geometry.size)
            }
            .alert(isPresented: $isCompleted) {
                Alert(
                    title: Text("Congratulations!"),
                    message: Text("Puzzle completed."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    func setupPuzzle(screenSize: CGSize) {
        guard let uiImage = UIImage(named: "2") else { return }
        let images = splitImageIntoPieces(image: uiImage, rows: rows, cols: cols)
        pieces = []

        let puzzleAreaWidth = pieceWidth * CGFloat(cols)
        let puzzleAreaHeight = pieceHeight * CGFloat(rows)
        let minX = (screenSize.width - puzzleAreaWidth) / 2
        let bottomY = screenSize.height - pieceHeight - 20 // Align pieces at the bottom with padding

        for row in 0..<rows {
            for col in 0..<cols {
                let correctPosition = CGPoint(
                    x: CGFloat(col) * pieceWidth + pieceWidth / 2,
                    y: CGFloat(row) * pieceHeight + pieceHeight / 2
                )
                let currentPosition = CGPoint(
                    x: minX + CGFloat(col) * pieceWidth + pieceWidth / 2,
                    y: bottomY
                )
                let piece = PuzzlePiece(
                    image: Image(uiImage: images[row * cols + col]),
                    correctPosition: correctPosition,
                    currentPosition: currentPosition
                )
                pieces.append(piece)
            }
        }
    }

    func splitImageIntoPieces(image: UIImage, rows: Int, cols: Int) -> [UIImage] {
        guard let cgImage = image.cgImage else { return [] }
        let pieceWidth = cgImage.width / cols
        let pieceHeight = cgImage.height / rows

        var pieces: [UIImage] = []

        for row in 0..<rows {
            for col in 0..<cols {
                let rect = CGRect(
                    x: col * pieceWidth,
                    y: row * pieceHeight,
                    width: pieceWidth,
                    height: pieceHeight
                )
                if let croppedCGImage = cgImage.cropping(to: rect) {
                    pieces.append(UIImage(cgImage: croppedCGImage))
                }
            }
        }

        return pieces
    }
}

// MARK: - ContentView
struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 249/255, blue: 219/255).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Puzzle Game\nSwiftUI")
                    .foregroundColor(.green)
                    .font(.system(size: 35))
                    .multilineTextAlignment(.center)
                    .kerning(-1)
                Spacer()
                PuzzleView()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
