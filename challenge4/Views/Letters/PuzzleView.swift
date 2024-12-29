//
//  PuzzleView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI

struct PuzzleView: View {
    let picsArray = ["pic1", "pic2", "pic3", "pic4", "pic5", "pic6"]
    @ObservedObject var child: Child
    @State private var isActivityCompleted = false
    @Binding var completedLetters: [Bool]
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("puzzle___")
                    .opacity(0.3)

                ScrollView(.horizontal) {
                    HStack{
                        ForEach(0..<picsArray.count, id: \.self) { index in
                            Image(picsArray[index])
                        }
                    }
                }
                NavigationLink(destination: ColoringView(child:child, completedLetters: $completedLetters)) {
                    Text("Next")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarBackButtonHidden(true)
            .globalFont(size: 150)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PrimaryColor"))
            .ignoresSafeArea()
        }
    }
}
