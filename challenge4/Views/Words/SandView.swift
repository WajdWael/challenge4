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
import AVFoundation

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
    @Binding var isActivityCompleted: Bool
    @State private var navigateToHomePage = false  // Flag to trigger navigation
    @State private var audioPlayer: AVAudioPlayer?
    var isLocked: Bool
    var body: some View {
        
        let word = words[child.currentWordIndex]
        ZStack{
            VStack{

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
                    Text(word.word)
                        .globalFont(size: 70)
                        .bold()
                        .padding()
                    
                    Spacer()
                }.padding()

                
                VStack(spacing: 8) {
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
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.clearCanvas()
                        }) {
                            Image(systemName: "trash")
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
                        .padding()
                        Button(action: {
                            showPopup = true // Show the pop-up
                        }) {
                            Image(systemName: "checkmark")
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
                }.onAppear(){
                    playSound(for: "جرب كتابة الكلمة على الرمل")
                }
            }
            .padding()
            .ignoresSafeArea()
        }
        .padding()
        .background(Color("PrimaryColor").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        .background(Color("PrimaryColor"))
        
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
                            
                            Text("لقد تعلمنا كلمة (\(word.word))\nهل استمتعت بالتعلم؟🧐")
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
                                    destination: Words_Levels(child: child,  completedWords: $completedWords, completedLetters:$completedLetters, isActivityCompleted:$isActivityCompleted, isLocked: isLocked),
                                    isActive: $navigateToHomePage,
                                    label: { EmptyView() }
                                )
                            ).navigationBarBackButtonHidden(true)
                        }.padding()
                        .frame(width: 644, height: 594)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .onAppear{
                            playSound(for: "Clapping")
                        }
                    }
                }
            }
        )
        
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()

    }
    
    func markWordAsCompleted() {
        var word  = words[child.currentWordIndex]
        word.isCompleted = true
            if child.currentWordIndex < words.count - 1  {
                completedWords[child.currentWordIndex] = true
                child.currentWordIndex += 1
            } else {
                child.currentWordIndex = 0
            }
        }
    
    func playSound(for part: String) {
        // اسم الملف الصوتي يجب أن يتطابق مع النص (part)
        if let soundURL = Bundle.main.url(forResource: part, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound for \(part): \(error.localizedDescription)")
            }
        } else {
            print("Sound file for \(part) not found.")
        }
    }
}
