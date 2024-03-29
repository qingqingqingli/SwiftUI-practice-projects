//
//  Created by Qing Li on 15/07/2022.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingGameFinal = false
    
    @State private var animationAmount = 0.0
    @State private var tappedFlagIndex = 0
    @State private var opacityDegree = 1.0
    
    func flagTapped(_ number: Int) {
        tappedFlagIndex = number
        opacityDegree = 0.25
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
        if score == 5 {
            showingGameFinal = true
            showingScore = false
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityDegree = 1
    }
    
    func resetGame(){
        countries.shuffle()
        score = 0
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundColor(.secondary)
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation(.default) {
                                animationAmount += 360
                            }
                        } label: {
                            FlagImage(name: countries[number])
                        }
                        .rotation3DEffect(
                            .degrees(number == tappedFlagIndex ? animationAmount : 0.0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(number != tappedFlagIndex ? opacityDegree : 1)
                        .animation(.interpolatingSpring(stiffness: 10, damping: 5), value: opacityDegree)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .alert("You've reached the final of the game", isPresented: $showingGameFinal) {
                        Button("Reset game", action: resetGame)
                    }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12")
    }
}
