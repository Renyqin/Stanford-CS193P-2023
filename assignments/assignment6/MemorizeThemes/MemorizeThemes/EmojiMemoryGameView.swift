//
//  ContentView.swift
//  Memorize
//
//  Codes from CS193P Instructor, modified by Chenqin Zhang on 2024/03/19
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
        
    var body: some View {
        VStack {
            Text(viewModel.theme.name)
                .font(.largeTitle)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            
            HStack {
                Spacer()
                Text("Score: \(viewModel.score)")
                    .foregroundColor(viewModel.score>=0 ? .green: .red)
                    
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
                Spacer()
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Spacer()
            }
            .font(.title2)
            
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:85), spacing:  0)], spacing: 0){
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.theme.Color)
    }
}





struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0: 1)
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
