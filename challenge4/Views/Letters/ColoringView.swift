//
//  ColoringView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI

struct ColoringView: View {
    let image: String // The name of the image
    @State private var points: [CGPoint] = [] // To store the drawing points
    @State private var currentPoint: CGPoint? // Current point while drawing
    @State private var brushColor: Color = .red // Brush color
    
    @ObservedObject var child: Child
    @State private var isActivityCompleted = false
    @Binding var completedLetters: [Bool]
    
    var body: some View {
        ZStack {
            // The background image
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300) // You can adjust the size
                .overlay(
                    GeometryReader { geometry in
                        // Drawing layer
                        Path { path in
                            // Draw all stored points
                            for point in points {
                                path.addEllipse(in: CGRect(x: point.x, y: point.y, width: 10, height: 10)) // Brush size is 10
                            }
                        }
                        .stroke(brushColor, lineWidth: 10) // Brush stroke color and size
                        .background(Color.clear) // Ensure the background is clear for drawing
                        .gesture(
                            DragGesture(minimumDistance: 0) // Gesture to track touch
                                .onChanged { value in
                                    // Add the current touch point to the points array
                                    points.append(value.location)
                                }
                        )
                    }
                )
        }
        .padding()
        .gesture(
            DragGesture(minimumDistance: 0) // Optional: Detecting drag
                .onChanged { value in
                    currentPoint = value.location
                }
        )
    }
}

//struct ColoringView: View {
//    let picsArray = [
//        "Black",
//        "Brown",
//        "DarkBlue",
//        "DarkOrange",
//        "DarkPink",
//        "DarkPurple",
//        "DarkYellow",
//        "Green-1",
//        "Green",
//        "Light",
//        "LightBlue2",
//        "LightGreen-1",
//        "LightGreen",
//        "LightOrange",
//        "LightPink",
//        "LightPurple-1",
//        "LightPurple",
//        "LightYellow",
//        "Pink-1",
//        "Pink",
//        "Red",
//    ]
//    @ObservedObject var child: Child
//    @State private var isActivityCompleted = false
//    @Binding  var completedLetters: [Bool]
//
//    
////    var body: some View {
////        NavigationStack {
////            Image("A-arabic-Coloring")
////            
////            ScrollView(.horizontal) {
////                HStack{
////                    ForEach(0..<picsArray.count, id: \.self) { index in
////                        Image(picsArray[index])
////                    }
////                }
////            }
////            NavigationLink(destination: HomeViewLetters(child: child, completedLetters: $completedLetters)) {
////                Text("Next")
////                    .font(.title)
////                    .fontWeight(.bold)
////                    .padding()
////                    .background(Color.blue)
////                    .foregroundColor(.white)
////                    .cornerRadius(10)
////            }
////        }
////        .ignoresSafeArea()
////        .navigationBarBackButtonHidden(true)
////        .globalFont(size: 150)
////        .frame(maxWidth: .infinity, maxHeight: .infinity)
////        .background(Color("PrimaryColor"))
////    }
//}
//      
