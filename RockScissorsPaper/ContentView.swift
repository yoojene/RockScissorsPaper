//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Eugene on 13/08/2023.
//

import SwiftUI

//
//struct ButtonStyle: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//
//            .overlay(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
//                                    .stroke(Color.black, lineWidth: 2.5))
//    }
//}
struct ContentView: View {

    let movesDict = [
        "Rock": "🪨",
        "Scissors": "✂️",
        "Paper": "📄"
    ]

    let moves = [
        "🪨",
        "✂️",
        "📄"
    ]

    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()

    @State private var score: Int = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var gameEnded = false

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

                    // Dictionary way, cannot index by number
    //                ForEach(moves.sorted(by: >), id: \.key) {key, value in
    //                    Button {
    //                        print("tapped button")
    //                    } label : {
    //                        Text("\(key) \(value) ")
    //                            .font(.largeTitle)
    //                    }
    //
    //                }

                    ForEach(0..<moves.count, id: \.self) { number in

                        Button {
                            calculateWinOrLose(for: number, toWin: shouldWin)
                           } label : {
                               Text(moves[number])
                               .font(.system(size: 100))
                           }
                        
                        }
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

    func calculateWinOrLose(for number: Int, toWin playerToWin: Bool) {
        print("Player chose \(moves[number]) with \(number)")
        print("App chose \(moves[appChoice]) with \(appChoice)")
        print("Player wants to win? \(playerToWin)")


        print(moves)


        let playerChoice = moves[number]
        let appChoice = moves[appChoice]

        if appChoice == playerChoice {
            // neither win nor lose
            return
        }







        if appChoice == "✂️" && playerChoice == "🪨" {

            if playerToWin == true {
                // player wins
                score += 1
                scoreTitle = "You Win"
            } else {
                score -= 1
                scoreTitle = "You Lose"

            }
        }
        if appChoice == "✂️" && playerChoice == "📄" {
            // app wins
            if playerToWin == false {
                // player wins
                score += 1
                scoreTitle = "You Win"

            } else {
                score -= 1
                scoreTitle = "You Lose"

            }
        }

        if appChoice == "🪨" && playerChoice == "✂️"  {
            // app wins

            if playerToWin == false {
                // player wins
                score += 1
                scoreTitle = "You Win"

            } else {
                scoreTitle = "You lose"
                score -= 1
            }
        }
        if appChoice == "🪨" && playerChoice == "📄"  {
            // player wins
            if playerToWin == true {
                // player wins
                score += 1
                scoreTitle = "You Win"

            } else {
                score -= 1
                scoreTitle = "You lose"

            }
        }

        if appChoice == "📄" && playerChoice == "✂️" {
            // player wins
            if playerToWin == true {
                // player wins
                score += 1
                scoreTitle = "You Win"

            } else {
                scoreTitle = "You Lose"
                score -= 1
            }
        }
        if appChoice == "📄" && playerChoice == "🪨" {
            // app wins
            if playerToWin == false {
                // player wins
                score += 1
                scoreTitle = "You Win"

            } else {
                score -= 1
                scoreTitle = "You Lose"

            }
        }

        if score > 2 {
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

