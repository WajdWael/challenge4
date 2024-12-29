//
//  ColoringView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
struct Line {
    var points: [CGPoint] = [] // Default empty array for points
    var color: Color = .red    // Default color
    var lineWidth: CGFloat = 2.0  // Default line width

    init(points: [CGPoint] = [], color: Color = .red, lineWidth: CGFloat = 2.0) {
        self.points = points
        self.color = color
        self.lineWidth = lineWidth
    }
}

struct ColoringView: View {
    @ObservedObject var child: Child
    @State private var isActivityCompleted = false
    @Binding var completedLetters: [Bool]

    @State private var currentLine = Line() // Initialize Line struct here
    @State private var lines: [Line] = []

    @State private var selectedColor: Color = .clear // Initialize with a clear color

    var body: some View {
        let letter = letters[child.currentWordIndex]
        let imageName = letter.coloringCanvas // Assuming coloringCanvas is the image name

        GeometryReader { geometry in
            VStack {
                // Top buttons (adjusted for iPad layout)
                HStack {
                    // Home button
                    NavigationLink(destination: HomeViewLetters(child: child, completedLetters: $completedLetters)) {
                        
                        Image(systemName: "house.circle")
                            .resizable()
                            .foregroundStyle(Color.orange)
                            .frame(width: 48, height: 48)
                    }

                    Spacer()

                    // Forward button
                    NavigationLink(destination: HomeViewLetters(child: child, completedLetters: $completedLetters)) {
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .foregroundStyle(Color.orange)
                            .frame(width: 48, height: 48)
                    }
                }
                .padding(.top, 10) // Add a small top padding for spacing

                // Image and Canvas (filling available space)
                ZStack {
                    // Correctly load and display the image as background
                    Image(imageName) // Use the image name here
                        .resizable()
                        .scaledToFit() // Adjust the image to fit within the view
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5) // Adjust the size based on available space

                    // Canvas overlay for drawing
                    Canvas { context, size in
                        for line in lines {
                            var path = Path()
                            path.addLines(line.points)
                            context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            let newPoint = value.location
                            currentLine.points.append(newPoint)
                            currentLine.color = selectedColor // Use the selected color
                            lines.append(currentLine)
                        }
                        .onEnded { _ in
                            currentLine = Line(points: [], color: selectedColor) // Keep color after drawing
                        })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Color Picker (positioned below the canvas)
                ColorPickerView(selectedColor: $selectedColor)
                    .padding(.top, 5) // Small top padding
            }
            .navigationBarBackButtonHidden(true)
            .background(Color("PrimaryColor")) // Set the background color
        }
    }
}
