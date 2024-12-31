import SwiftUI
struct PuzzlePiece: Identifiable {
    var id = UUID()
    var image: UIImage
    var correctPosition: CGPoint
    var currentPosition: CGPoint
    var isLocked: Bool = false
}

struct PuzzleView: View {
    @State private var pieces: [PuzzlePiece] = []
    @State private var isPuzzleComplete = false
    @State private var navigateToHome = false
    @Binding var completedLetters: [Bool]
    @ObservedObject var child: Child
    @State private var showPopup = false // State to toggle the pop-up

    let pieceWidth: CGFloat = 951 / 3
    let pieceHeight: CGFloat = 543 / 2
    @State private var navigateToNextLetter = false

    var body: some View {
        let letter = letters[child.currentLetterIndex]
        let imageName = letter.puzzleImage
        
        
        ScrollView {
                
                ZStack {
                    Color("PrimaryColor").ignoresSafeArea()

                    VStack {
                        // Navigation and Home Button
                        HStack {
                            NavigationLink(destination: HomeViewLetters(child: child, completedLetters: $completedLetters)) {
                                Image(systemName: "house.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 81, height: 81)
                                    .background(
                                        RoundedRectangle(cornerRadius: 100)
                                            .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255))
                                            .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                                    )
                            }
                            Spacer()
                        }.padding()
                        

                        // Puzzle Area
                        ZStack {
                            // Reference Image
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 951, height: 543)
                                .opacity(0.2)

                            // Draggable Puzzle Pieces in the Puzzle Area
                            ForEach(pieces.filter { $0.isLocked }) { piece in
                                Image(uiImage: piece.image)
                                    .resizable()
                                    .frame(width: pieceWidth, height: pieceHeight)
                                    .position(piece.currentPosition)
                            }
                        }
                        .frame(width: 951, height: 543)

    //                    if isPuzzleComplete {
                            HStack {
                                // right nav
                                NavigationLink(destination: ColoringView(child: child, completedLetters: $completedLetters)) {
                                    Image(systemName: "arrowshape.right.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 81, height: 81) // Expand to fill horizontal space
                                        .background(
                                            RoundedRectangle(cornerRadius: 100)
                                                .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                                .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                                        )
                                }
                                Spacer()
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(pieces.filter { !$0.isLocked }) { piece in
                                            Image(uiImage: piece.image)
                                                .resizable()
                                                .frame(width: pieceWidth, height: pieceHeight)
                                                .contentShape(Rectangle()) // Ensure entire frame is tappable
                                                .gesture(
                                                    DragGesture(minimumDistance: 0) // Start gesture immediately
                                                        .onChanged { value in
                                                            let index = pieces.firstIndex(where: { $0.id == piece.id })!
                                                            pieces[index].currentPosition = CGPoint(
                                                                x: piece.correctPosition.x + value.translation.width,
                                                                y: piece.correctPosition.y + value.translation.height
                                                            )
                                                        }
                                                        .onEnded { value in
                                                            let index = pieces.firstIndex(where: { $0.id == piece.id })!
                                                            checkPlacement(for: &pieces[index])
                                                            checkIfPuzzleComplete()
                                                        }
                                                )
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(height: pieceHeight)
                                
                                Spacer()
                                
                                // left nav
                                
                                Button(action: {
                                    showPopup = true // Show the pop-up
                                }) {
                                    Image(systemName: "arrowshape.left.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white) // Foreground color (#464646)
                                        .padding()
                                        .frame(width: 81, height: 81) // Expand to fill horizontal space
                                        .background(
                                            RoundedRectangle(cornerRadius: 100)
                                                .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                                .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                                        )
                                }
                                .padding(.top, 20)
                            }
                            .padding()                 
                        
                            
                        

                    }
                }
                .onAppear {
                    setupPuzzle(for: letter)
                }
//                .alert(isPresented: $isPuzzleComplete) {
//                    Alert(
//                        title: Text("Congratulations!"),
//                        message: Text("You completed the puzzle!"),
//                        dismissButton: .default(Text("Back to Home")) {
//                            markLetterAsCompleted()
//                            navigateToNextLetter = true
//                        }
//                    )
//                }
                
            }
        .padding()
        .navigationBarBackButtonHidden(true)
        .background(Color("PrimaryColor"))
        .ignoresSafeArea()
        .overlay(
            Group {
                if showPopup {
                    ZStack {
                        // Background overlay
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)

                        // Pop-up rectangle
                        VStack(spacing: 10) {
                            Text("مبروك 🎉")
                                .globalFont(size: 60)
                                .bold()
                                .foregroundStyle(Color(.black))
                            
                            Text("لقد تم انهاء الحرف")
                                .globalFont(size: 40)
                            
                            Image("SingleCharacter")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.75)

                            NavigationLink(
                                destination: Letters_Levels(child: child, completedLetters: $completedLetters),
                                isActive: $navigateToHome
                            ) {
                                Button(action: {
                                    markLetterAsCompleted()
                                    navigateToHome = true
                                }) {
                                    Text("انهاء")
                                        .globalFont(size: 30)
                                        .fontWeight(.bold)
                                        .padding()
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                        .frame(width: 644, height: 594)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    }
                }
            }
        )

    }

    private func setupPuzzle(for letter: Letter) {
        guard let bigImage = UIImage(named: letter.puzzleImage),
              let cgImage = bigImage.cgImage else { return }

        let rows = 2
        let cols = 3
        let croppedPieceWidth = cgImage.width / cols
        let croppedPieceHeight = cgImage.height / rows

        pieces = []

        for row in 0..<rows {
            for col in 0..<cols {
                // Reverse the column index to fix the horizontal flipping
                let flippedCol = (cols - 1) - col
                
                let rect = CGRect(
                    x: flippedCol * croppedPieceWidth, // Use flippedCol instead of col
                    y: row * croppedPieceHeight,
                    width: croppedPieceWidth,
                    height: croppedPieceHeight
                )
                if let croppedCGImage = cgImage.cropping(to: rect) {
                    let correctPosition = CGPoint(
                        x: CGFloat(col) * pieceWidth + pieceWidth / 2,
                        y: CGFloat(row) * pieceHeight + pieceHeight / 2
                    )
                    let currentPosition = CGPoint(x: CGFloat.random(in: 50...300), y: CGFloat.random(in: 600...700)) // Random initial position
                    pieces.append(PuzzlePiece(
                        image: UIImage(cgImage: croppedCGImage),
                        correctPosition: correctPosition,
                        currentPosition: currentPosition
                    ))
                }
            }
        }
    }
    
    private func checkPlacement(for piece: inout PuzzlePiece) {
        let snapThreshold: CGFloat = pieceWidth / 3
        if abs(piece.currentPosition.x - piece.correctPosition.x) < snapThreshold &&
            abs(piece.currentPosition.y - piece.correctPosition.y) < snapThreshold {
            piece.currentPosition = piece.correctPosition
            piece.isLocked = true
        }
    }

    private func checkIfPuzzleComplete() {
        isPuzzleComplete = pieces.allSatisfy { $0.isLocked }
        if isPuzzleComplete {
            child.markCurrentLetterCompleted()
        }
    }


    private func markLetterAsCompleted() {
        completedLetters[child.currentLetterIndex] = true
        
        if child.currentLetterIndex < letters.count - 1 {
            
            completedLetters[child.currentLetterIndex] = true
            
            child.currentLetterIndex += 1
            
        } else {
            print("All letters completed!")
        }
       
    }
}
