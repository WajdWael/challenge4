//
//  ColoringView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
import PencilKit

struct ColoringView: View {
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    @State private var isToolPickerVisible: Bool = false
    @State private var scale: CGFloat = 1.0
        
    @ObservedObject var child: Child
    @State private var isActivityCompleted = false
    @Binding var completedLetters: [Bool]
    @Binding var completedWords: [Bool]
    var isLocked : Bool
    
    
    var body: some View {
        let letter = letters[child.currentLetterIndex]
        let imageName = letter.coloringCanvas
        
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()

            VStack {
                // Home Button
                HStack{
                    NavigationLink(destination: New_Home_Page(child: child, completedWords:$completedWords, completedLetters: $completedLetters, isLocked: isLocked)) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 81, height: 81)
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                            )
                    }
                    Spacer()
                }.padding()
                
                // View content
                ZStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .frame(width: 1085, height: 484)
                    
                    PencilKitCanvasView(canvasView: $canvasView, toolPicker: $toolPicker)
                        .frame(width: 1085, height: 484)
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                
                HStack {
                    // right nav
                    NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child, completedWords:$completedWords, isActivityCompleted:$isActivityCompleted, isLocked:isLocked)) {
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
                    
                    // view content
                    Button(action: {
                        withAnimation {
                            isToolPickerVisible.toggle()
                            if isToolPickerVisible {
                                toolPicker.setVisible(true, forFirstResponder: canvasView)
                                canvasView.becomeFirstResponder()
                            } else {
                                toolPicker.setVisible(false, forFirstResponder: canvasView)
                                canvasView.resignFirstResponder()
                            }
                        }
                    }) {
                        Image(systemName: "scribble.variable")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(isToolPickerVisible ? .blue : .gray)
                            .padding()
                    }
                    Button(action: {
                        canvasView.drawing = PKDrawing()
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    // left nav
                    Spacer()
                    
                    NavigationLink(destination: PuzzleView(completedLetters: $completedLetters, child: child, completedWords:$completedWords, isLocked: isLocked)) {
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
                    .onTapGesture {
                        child.markCurrentLetterCompleted()
                    }
                }
                .padding()
            }
        }
        .onAppear {
            setupToolPicker()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .background(Color("PrimaryColor"))
        .ignoresSafeArea()
    }
    
    private func setupToolPicker() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let _ = scene.windows.first {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        }
    }
}

struct PencilKitCanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.backgroundColor = .clear // Ensure the canvas is transparent
        canvasView.drawingPolicy = .anyInput // Allow touch inputs for drawing
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // Update logic if needed
    }
}


//                    Button(action: {
//
//                    }) {
//                        Text("رجوع")
//                            .globalFont(size: 50)
//                            .foregroundColor(Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255))
//                            .padding()
//                            .frame(width: 247, height: 81)
//                            .background(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255))
//                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
//                            )
//                    }


// Next Button
//                    Button(action: {
//                        print("Next button pressed")
//                    }) {
//                        Text("التالي")
//                            .globalFont(size: 50)
//                            .foregroundColor(Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255)) // Foreground color (#464646)
//                            .padding()
//                            .frame(width: 247, height: 81) // Expand to fill horizontal space
//                            .background(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
//                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
//                            )
//                    }
