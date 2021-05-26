//
//  GameView.swift
//  TicTacToe
//
//  Created by Cédric Bahirwe on 26/05/2021.
//

import SwiftUI

struct GameView: View {
    @State private var hasStarted = false
    @State private var isHuman = false
    private let rows = 3
    private let columns = 3
    @State private var items  = [Item](repeating: .example, count: 9)
    @State private var showAlert = false
    var body: some View {
        VStack {
            HStack {
                Image("check")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("@eventsBash")
                        .font(.callout)
                    Text("EventsBash")
                        .font(.caption)

                }
                Spacer()
                Label("05:00", systemImage: "alarm")
                    .font(.system(size: 16, weight: .bold))
                    .padding(8)
                    .background(Color(.tertiarySystemGroupedBackground))
                    .cornerRadius(6)
            }
            .padding(.horizontal, 8)
            GridStack(rows: rows, columns: columns) { row, column in
                ZStack {
                    Rectangle()
                        .stroke(Color(.label), lineWidth: 3)
                        .frame(maxWidth: 100, maxHeight: 100)
                        .background(Color(.systemBackground))
                        .onTapGesture {
                            items[indexFor(row,column)].hasbeenSelected.toggle()
                            items[indexFor(row,column)].isHuman = isHuman
                            isHuman.toggle()
                            
                            if isWinner().0 {
                                showAlert = true
                                print(isWinner().1)
                            }
                    }
                    
                    Image(items[indexFor(row,column)].hasbeenSelected ? (items[indexFor(row,column)].isHuman ? "human" : "cpu") : "circle")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .allowsHitTesting(false)
                }
                
            }
//            .hidden()
            Button(action: {
                items = [Item](repeating: .example, count: 9)
                
            }) {
                Text("Reset")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.label), Color(.red)]), startPoint: .bottomLeading, endPoint: .trailing))
                    .clipShape(Capsule())
            }
            .animation(.spring())
            .transition(.scale(scale: 0.8, anchor: .center))
            .opacity(items.map({ $0.hasbeenSelected }).allSatisfy({ $0 }) ? 1 : 0)
        }
        .alert(isPresented:$showAlert) {
            Alert(title: Text("Winner"), message: Text(isWinner().1), dismissButton: .default(Text("Dismiss")){
               items = [Item](repeating: .example, count: 9)
                })
        }
    }
    
    private func indexFor(_ row: Int, _ column: Int) -> Int {
        return  row * columns + column
    }
    
    private func isWinner() -> (Bool, String) {
        let case1  = [items[0],  items[1], items[2]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case2  = [items[3],  items[4], items[5]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case3  = [items[6],  items[7], items[8]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case4  = [items[0],  items[3], items[6]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case5  = [items[1],  items[4], items[7]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case6  = [items[2],  items[5], items[8]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case7  = [items[0],  items[4], items[8]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        let case8  = [items[2],  items[4], items[6]].allSatisfy({ $0.isHuman && $0.hasbeenSelected })
        
        let pcase1  = [items[0],  items[1], items[2]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase2  = [items[3],  items[4], items[5]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase3  = [items[6],  items[7], items[8]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase4  = [items[0],  items[3], items[6]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase5  = [items[1],  items[4], items[7]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase6  = [items[2],  items[5], items[8]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase7  = [items[0],  items[4], items[8]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
        let pcase8  = [items[2],  items[4], items[6]].allSatisfy({ !$0.isHuman && $0.hasbeenSelected })
          
        
        if case1 || case2 || case3 || case4 || case5 || case6 || case7 || case8 {
            return (true, "Check won the game!!!")
        } else if pcase1 || pcase2 || pcase3 || pcase4 || pcase5 || pcase6 || pcase7 || pcase8 {
             return (true, "Cross won the game!!!")
        } else {
             return (false, "No Winner!!")
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
//            .preferredColorScheme(.dark)
    }
}
