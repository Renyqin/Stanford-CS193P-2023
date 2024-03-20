//
//  EmojiArtDocumentView.swift
//  Emoji Art
//
//  Created by CS193p Instructor on 5/8/23.
//  Copyright (c) 2023 Stanford University
//

import SwiftUI

struct EmojiArtDocumentView: View {
    typealias Emoji = EmojiArt.Emoji
    
    @ObservedObject var document: EmojiArtDocument
    
    private let paletteEmojiSize: CGFloat = 40

    var body: some View {
        VStack(spacing: 0) {
            documentBody
            PaletteChooser()
                .font(.system(size: paletteEmojiSize))
                .padding(.horizontal)
                .scrollIndicators(.hidden)
        }
    }
    
    private var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                documentContents(in: geometry)
                    .scaleEffect(zoom * gestureZoom)
                    .offset(pan + gesturePan)
                
                
            }
//            .gesture(panGesture.simultaneously(with: zoomGesture))
            .gesture(panGesture)
            .gesture(zoomGesture)
            .dropDestination(for: Sturldata.self) { sturldatas, location in
                return drop(sturldatas, at: location, in: geometry)
            }
            
        }
    }
    
    @State private var selectedEmoji = Set<Emoji.ID>()
    
    @ViewBuilder
    private func documentContents(in geometry: GeometryProxy) -> some View {
        AsyncImage(url: document.background)
            .position(Emoji.Position.zero.in(geometry))
            .onTapGesture {
                selectedEmoji = Set<Emoji.ID>()
            }
            
        
        ForEach(document.emojis) { emoji in
            Text(emoji.string)
                .font(emoji.font )
                .border(selectedEmoji.contains(emoji.id) ? .blue : .clear)
                .overlay(selectedEmoji.contains(emoji.id) ?
                         
                         GeometryReader { geometry in
                             Image(systemName: "xmark.circle.fill")
                                 .foregroundColor(.red)
                                 .font(.system(size: 20))
                                 .padding(8)
                                 .onTapGesture {
                                      document.removeEmoji(withID: emoji.id)
                                 }
                                 .alignmentGuide(.trailing) { _ in
                                     geometry.size.width // Adjust the padding as per your needs
                                 }
                                 .alignmentGuide(.top) { _ in
                                     geometry.size.height  // Adjust the padding as per your needs
                                 }
                         }
                         
                         
                         : nil)
                

                .scaleEffect( selectedEmoji.contains(emoji.id) ? CGFloat(emoji.size) / paletteEmojiSize * emojiZoom : CGFloat(emoji.size) / paletteEmojiSize)
                .gesture(tapGesture(with: emoji).simultaneously(with: dragGesture(with: emoji)))
                .position(emoji.position.in(geometry))
  
        }
    }
    
    
    private func tapGesture(with emoji: Emoji) -> some Gesture {
        TapGesture()
            .onEnded {
                if !selectedEmoji.contains(emoji.id){
                    selectedEmoji.insert(emoji.id)
                } else {
                    selectedEmoji.remove(emoji.id)
                }
                print(selectedEmoji.count)
            }
    }
    
    
    // TODO: change if else to use gesture state to control
    private func dragGesture(with emoji: Emoji) -> some Gesture {
        if !selectedEmoji.contains(emoji.id){
            DragGesture()
                .onChanged() { moveValue in
                    document.move(emoji, by: moveValue.translation)
                }
                .onEnded { moveValue in
                    document.move(emoji, by: moveValue.translation)
                }
        } else {
            DragGesture()
                .onChanged() { moveValue in
                    for emoji in selectedEmoji {
                        document.move(emojiWithId: emoji, by: moveValue.translation)
                    }
                    
                }
                .onEnded { moveValue in
                    for emoji in selectedEmoji {
                        document.move(emojiWithId: emoji, by: moveValue.translation)
                    }
                }
        }
    }

    @State private var zoom: CGFloat = 1
    @State private var pan: CGOffset = .zero
    
    @GestureState private var emojiZoom: CGFloat = 1
    @GestureState private var gestureZoom: CGFloat = 1
    @GestureState private var gesturePan: CGOffset = .zero
    
    
    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($gestureZoom) { inMotionPinchScale, gestureZoom, _ in
                if selectedEmoji.count == 0 {
                    gestureZoom = inMotionPinchScale
                    
                }
            }
            .updating($emojiZoom, body: { inMotionPinchScale, emojiZoom, _ in
                if selectedEmoji.count > 0 {
                    emojiZoom = inMotionPinchScale
                    print(emojiZoom)
                }
            })
        
            .onEnded { endingPinchScale in
                if selectedEmoji.count > 0 {
                    for emoji in selectedEmoji {
                        document.resize(emojiWithId: emoji, by: endingPinchScale)
                    }
                } else {
                    zoom *= endingPinchScale
                }
                
            }
    }
    
    private var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { inMotionDragGestureValue, gesturePan, _ in
                gesturePan = inMotionDragGestureValue.translation
            }
            .onEnded { endingDragGestureValue in
                pan += endingDragGestureValue.translation
            }
    }
    
    private func drop(_ sturldatas: [Sturldata], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        for sturldata in sturldatas {
            switch sturldata {
            case .url(let url):
                document.setBackground(url)
                return true
            case .string(let emoji):
                document.addEmoji(
                    emoji,
                    at: emojiPosition(at: location, in: geometry),
                    size: paletteEmojiSize / zoom
                )
                return true
            default:
                break
            }
        }
        return false
    }
    
    private func emojiPosition(at location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
        let center = geometry.frame(in: .local).center
        return Emoji.Position(
            x: Int((location.x - center.x - pan.width) / zoom),
            y: Int(-(location.y - center.y - pan.height) / zoom)
        )
    }
}

struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
            .environmentObject(PaletteStore(named: "Preview"))
    }
}
