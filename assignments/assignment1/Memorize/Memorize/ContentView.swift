//
//  ContentView.swift
//  Memorize
//
//  Codes from CS193P Instructor
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["👻","🎃","🕷️","😈","💀","🕸️","🧙","🙀","👹","😱","☠️","🍭","👻","🎃","🕷️","😈","💀","🕸️","🧙","🙀","👹","😱","☠️","🍭"].shuffled()
    @State var cardCount: Int = 24
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            
            themeChosing
            
        }
        .padding()
    }
    
    
    var themeChosing : some View {
        HStack(alignment: .bottom) {
            Spacer()
            themeButton(image: "theatermasks", themeTitle: "Halloween", emojis: ["👻","🎃","🕷️","😈","💀","🕸️","🧙","🙀","👹","😱","☠️","🍭"])
            Spacer()
            themeButton(image: "figure.badminton", themeTitle: "Sports", emojis: ["🚲", "🏀", "🏸", "⛹️‍♀️", "🎾", "🏓", "🏑", "⚾️", "🏈", "🏊‍♀️", "🏄🏿‍♀️", "🚵"])
            Spacer()
            themeButton(image: "car", themeTitle: "Vehicle", emojis: ["🚗", "🚖", "⛴️", "🚁", "🚚", "🚂", "🚀", "🚌", "🚑", "🚔", "🚜", "🚄"])
            Spacer()
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func themeButton(image: String, themeTitle: String, emojis: [String]) -> some View {
        Button(action: {
            self.emojis = (emojis + emojis).shuffled()
            
        }, label: {
            
            VStack {
                Image(systemName: image)
                Text(themeTitle)
                    .font(.body)
            }
        })
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:60))]){
            ForEach(0..<cardCount, id:\.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}





struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0: 1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
