//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Eugene on 13/08/2023.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content

            .overlay(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                    .stroke(Color.black, lineWidth: 2.5))
    }
}

extension View {
    func buttonStyle() ->  some View {
        modifier(ButtonStyle())
    }
}
struct ContentView: View {
    
    let moves = [
        "🪨",
        "📄",
        "✂️",
    ]

    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()

    @State private var score: Int = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var gameEnded = false

    var correctChoice: Int {
            if shouldWin {
                switch appChoice {
                case 0: return 1
                case 1: return 2
                case 2: return 0
                default: return 0
                }
            } else {
                switch appChoice {
                case 0: return 2
                case 1: return 0
                case 2: return 1
                default: return 0
                }
            }
        }
    var body: some View {

        ZStack {
            LinearGradient(
                 gradient: Gradient(colors: [Color(red: 0.4, green: 0.5, blue: 0.99), Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()

                Text("App has chosen:")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom)

                Text("\(moves[appChoice])")
                    .font(.system(size: 50))

                Spacer()

                if shouldWin {
                    Text("Choose option to win")
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    Text("Choose option to lose")
                        .font(.title)
                        .fontWeight(.bold)
                }

                Spacer()

                VStack(spacing: 15) {

                    ForEach(0..<moves.count, id: \.self) { number in
                        Button {
                            calculateWinOrLose(number)
                           } label : {
                               Text(moves[number])
                               .font(.system(size: 100))
                           }
                        
                    }
                    .buttonStyle()
                }
            
                Spacer()

                Text("Score is \(score)")
                    .font(.title)
                Spacer()
            }
            .alert("Game Over", isPresented: $gameEnded) {
                Button("Reset the game") {
                    resetGame()
                }
            } message: {
                Text("You have \(score) points in total")
            }

        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: next)
        } message:  {
            Text("Your score is \(score)")
        }


    }

    func calculateWinOrLose(_ number: Int) {

        if number == correctChoice {
            score += 1
            scoreTitle = "Correct"
        } else {
            score -= 1
            scoreTitle = "Bad Luck"
        }


        if score > 9 {
            gameEnded = true
        } else {
            showingScore = true

        }
    }

    func next() {
        appChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }

    func resetGame() {
        score = 0
        next()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

