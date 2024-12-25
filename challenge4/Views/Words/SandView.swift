//
//  SandView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.

//
//  Sand.swift
//  Trying
//
//  Created by Alaa Emad Alhamzi on 23/06/1446 AH.
//

import SwiftUI

// MARK: - Model
struct SandDrawPoint: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var isEraser: Bool
}

// MARK: - ViewModel
class SandDrawViewModel: ObservableObject {
    @Published var points: [SandDrawPoint] = []
    @Published var isEraser: Bool = false

    func addPoint(_ point: SandDrawPoint) {
        points.append(point)
    }

    func clearCanvas() {
        points.removeAll()
    }
}

// MARK: - ProgressBarView
struct progressBarView: View {
    var currentLevel: Int

    var body: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 400, height: 30)
                .cornerRadius(55)

            Rectangle()
                .fill(Color("Bar"))
                .frame(width: CGFloat(currentLevel) * 75, height: 30)
                .cornerRadius(55)
                .animation(.easeInOut, value: currentLevel)

            HStack(spacing: 75) {
                ForEach(0..<4) { _ in
                    Image("pumpkin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 55)
                }
            }
            .padding(.horizontal, -15)
        }
        .frame(width: 400, alignment: .trailing)
    }
}

// MARK: - SandDrawView
struct SandDrawView: View {
    @StateObject private var viewModel = SandDrawViewModel()
    @State private var showPopup = false // State to toggle the pop-up
    @ObservedObject var child : Child
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]
    @State private var navigateToHomePage = false  // Flag to trigger navigation
    
    var body: some View {
        
        let word = words[child.currentWordIndex]
        
        VStack(spacing: 8) {
            HStack {
                // Undo/Delete Button in Circle (on the left)
                Button(action: {
                }) {
                    Image(systemName: "house.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }
                Spacer()
                Button(action: {
                    viewModel.clearCanvas()
                }) {
                    Image(systemName: "trash.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }
            }
            .padding()

            // Text below the progress bar
            Text(word.word)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .globalFont(size: 60)

            // Drawing Rectangle with background image "sand_texture"
            ZStack {
                Image("Sand")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 952, height: 476)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                Canvas { context, size in
                    for point in viewModel.points {
                        let baseColor = point.isEraser ? Color("background") : Color(red: 0.76, green: 0.58, blue: 0.37)
                        
                        let shadowColor = Color.black.opacity(0.7)
                        let shadowOffset = CGSize(width: 2, height: 2)
                        let shadowRect = CGRect(x: point.x - 6 + shadowOffset.width, y: point.y - 6 + shadowOffset.height, width: 14, height: 14)
                        context.fill(Path(ellipseIn: shadowRect), with: .color(shadowColor))

                        let rect = CGRect(x: point.x - 6, y: point.y - 6, width: 14, height: 14)
                        context.fill(Path(ellipseIn: rect), with: .color(baseColor))
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let newPoint = SandDrawPoint(
                                x: value.location.x,
                                y: value.location.y,
                                isEraser: viewModel.isEraser
                            )
                            viewModel.addPoint(newPoint)
                        }
                )
            }
            .frame(width: 952, height: 476)

            // Check mark button under the drawing rectangle
            Button(action: {
                showPopup = true // Show the pop-up
            }) {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .foregroundStyle(Color.orange)
                    .frame(width: 78, height: 78)
            }
            .padding(.top, 20)
        }
        
        .background(Color("PrimaryColor").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)

        // Pop-up implementation
        .overlay(
            Group {
                if showPopup {
                    ZStack {
                        // Background overlay
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)

                        // Pop-up rectangle
                        VStack(spacing: 10){
                            
                            //ProgressBarView(child: child)
                            
                            Text("مبروك 🎉 ")
                                .globalFont(size: 60)
                                .bold()
                                .foregroundStyle(Color(.black))
                            
                            Text("لقد تم إنهاء كلمة (\(word.word))")
                                .globalFont(size: 40)
                            
                           Image("SingleCharacter")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.75)

                            Button(action: {
                                completedWords[child.currentWordIndex] = true
                                   markWordAsCompleted()
                                   navigateToHomePage = true
                            }) {
//                                Text("الصفحة الرئيسية")
//                                    .font(.title2)
//                                    .foregroundStyle(Color(.black))
//                                    .frame(width: 200, height: 70)
//                                    .background(Color("StichyNotes Rectangle"))
//                                    .cornerRadius(20)
                                
//                                Image(systemName: "house.circle")
//                                    .resizable()
//                                    .foregroundStyle(Color.orange)
//                                    .frame(width: 78, height: 78)
                                
                                Text("انهاء")
                                    .globalFont(size: 30)
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .background(
                                NavigationLink(
                                    destination: HomeViewWords(child: child,  completedWords: $completedWords, completedLetters:$completedLetters),
                                    isActive: $navigateToHomePage,
                                    label: { EmptyView() }
                                )
                            ).navigationBarBackButtonHidden(true)
                        }.padding()
                        .frame(width: 644, height: 594)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    }
                }
            }
        )
        
        .navigationBarBackButtonHidden(true)
    }
    
    func markWordAsCompleted() {
        
        var word  = words[child.currentWordIndex]
        
        word.isCompleted = true
        
        
            
            if   child.currentWordIndex < words.count - 1  {
                
                child.currentWordIndex += 1
            }else{
                child.currentWordIndex = 0
            }
        
        }
}
