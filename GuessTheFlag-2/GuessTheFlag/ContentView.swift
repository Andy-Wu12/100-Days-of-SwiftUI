//
//  ContentView.swift
//  Guess-the-Flag
//
//  Created by Andy Wu on 12/5/22.
//

import SwiftUI

let numFlags = 3

struct ContentView: View {
    // Animations
    @State private var guessed = false
    @State private var rotationAmount = Array(repeating: 0.0, count: numFlags)
    @State private var opacityLevel = Array(repeating: 1.0, count: numFlags)
    
    @State private var score = 0

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US", "Argentina", "Brazil", "Canada", "Columbia", "Greece", "Japan", "Monaco", "South Korea", "Switzerland", "Ukraine"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner",
        "Argentina": "Flag with three equally wide horizontal bands alternating sky blue and white in color. The white band in the middle has a yellow Sun of May",
        "Brazil": "Flag with green background and a yellow rhombus with blue disc depicting a starry sky in the center",
        "Canada": "Flag with a red background and white square in the center with a red maple leaf",
        "Columbia": "Flag with horizontal stripes of yellow, blue, and red from top to bottom. The yellow stripe is 2 times larger than the rest.",
        "Greece": "Flag with nine equal horizontal stripes of blue alternating with white. There is a blue square in the upper left corner bearing a white cross.",
        "Japan": "Flag is completely white except for red circle in the center",
        "Monaco": "Flag with two equal horizontal bands of red and white from top to bottom",
        "South Korea": "Flag with a white rectangular background, a red and blue taegeuk in it's center, along with a black trigram on each of the four corners.",
        "Switzerland": "Flag with a white cross in the center of a square red field",
        "Ukraine": "Flag with two equal horizontal bands of blue and yellow, from top to bottom."
    ]
    
    @State private var roundsPlayed = 0
    @State private var gameOver = false
    private let maxRounds = 10
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.5)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            if !guessed {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .rotation3DEffect(
                            .degrees(rotationAmount[number]),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(opacityLevel[number])
                        .shadow(color: guessed ? (number == correctAnswer ? .green : .red) : .clear,
                                radius: 5)
                        .accessibilityLabel(labels[countries[number], default: "Unknown country"])
                    }
                } .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                if guessed {
                    Button("Continue", action: askQuestion)
                        .foregroundColor(.black)
                        .font(.title.bold())
                }
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            } .padding()
            
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("Your score was \(score) / \(maxRounds)")
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation {
            rotationAmount[number] += 360
            for i in 0..<numFlags {
                if i != number {
                    opacityLevel[i] = 0.50
                }
            }
        }
        
        guessed = true
        if number == correctAnswer {
            score += 1
        }
    
        addRoundPlayed()
        // Reset animation values
        rotationAmount[number] = 0
    }
    
    func addRoundPlayed() {
        roundsPlayed += 1
        if roundsPlayed == maxRounds {
            gameOver = true
        }
    }
    
    func reset() {
        roundsPlayed = 0
        score = 0
        gameOver = false
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // Reset opacity levels before asking next question
        opacityLevel = Array(repeating: 1.0, count: numFlags)
        guessed = false
    }
}

/// ViewsAndModifiers Challenge 2 - replace Image view used for flags
/// with a new FlagImage() view that renders one flag image using the specific set of modifiers we had
struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
