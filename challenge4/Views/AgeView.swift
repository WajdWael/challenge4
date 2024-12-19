import SwiftUI
import SwiftData

struct AgeView: View {
    @State private var selectedAge: Int?  // Holds the selected age
    @State private var childModel: ChildModel?  // To store the selected child's data
    @State private var navigateToNextScreen = false  // Flag to trigger navigation

    let ages = [8, 7, 6, 5]

    var body: some View {
        NavigationStack {
            VStack {
                Text("اختر عمرك")
                    .globalFont(size: 150)
                    .padding(.top, 100)
                Spacer()
                HStack(spacing: 40) {
                    ForEach(ages, id: \.self) { age in
                        BalloonView(number: age, isSelected: selectedAge == age)
                            .onTapGesture {
                                selectedAge = age
                                updateChildModel(for: age)
                                navigateToNextScreen = true
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()

                Spacer()
            }
            .background(Color("PrimaryColor"))
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $navigateToNextScreen) {
                HomeView()
            }
        }
    }

    // Function to update the ChildModel based on selected age
    private func updateChildModel(for age: Int) {
        let name = "Child"
        let letters = [LetterModelMain]()
        let progress = 0.0
        childModel = ChildModel(name: name, age: age, letters: letters, progress: progress)
    }
}

// Custom Balloon View
struct BalloonView: View {
    let number: Int
    var isSelected: Bool

    var body: some View {
        VStack {
            Circle()
                .fill(balloonColor(for: number))
                .frame(width: 100, height: 130)
                .overlay(
                    Text("\(number)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                )
                .scaleEffect(isSelected ? 2.6 : 1.8)
                .animation(.spring(), value: isSelected)


            Path { path in
                path.move(to: CGPoint(x: 80, y: 0))
                path.addQuadCurve(to: CGPoint(x: 50, y: 80), control: CGPoint(x: 30, y:30 ))
            }
            .stroke(Color.black, lineWidth: 10)
            .frame(height:150)
        }
    }

    private func balloonColor(for number: Int) -> Color {
        switch number {
        case 8: return Color.pink
        case 7: return Color.orange
        case 6: return Color.blue
        case 5: return Color.cyan
        default: return Color.gray
        }
    }
}

// Preview
#Preview {
    AgeView()
}
