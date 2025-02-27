import SwiftUI

struct HomeView: View {
  let pieces: [Piece] = [
    Piece(color: .black, x: 1, y: 0),
    Piece(color: .black, x: 3, y: 0),
    Piece(color: .black, x: 5, y: 0),
    Piece(color: .black, x: 7, y: 0),
    Piece(color: .black, x: 0, y: 1),
    Piece(color: .black, x: 2, y: 1),
    Piece(color: .black, x: 4, y: 1),
    Piece(color: .black, x: 6, y: 1),
    Piece(color: .black, x: 1, y: 2),
    Piece(color: .black, x: 3, y: 2),
    Piece(color: .black, x: 5, y: 2),
    Piece(color: .black, x: 7, y: 2),
    Piece(color: Color.lightPiece, x: 0, y: 7),
    Piece(color: Color.lightPiece, x: 2, y: 7),
    Piece(color: Color.lightPiece, x: 4, y: 7),
    Piece(color: Color.lightPiece, x: 6, y: 7),
    Piece(color: Color.lightPiece, x: 1, y: 6),
    Piece(color: Color.lightPiece, x: 3, y: 6),
    Piece(color: Color.lightPiece, x: 5, y: 6),
    Piece(color: Color.lightPiece, x: 7, y: 6),
    Piece(color: Color.lightPiece, x: 0, y: 5),
    Piece(color: Color.lightPiece, x: 2, y: 5),
    Piece(color: Color.lightPiece, x: 4, y: 5),
    Piece(color: Color.lightPiece, x: 6, y: 5)
  ]
  
  let columns = Array(repeating: GridItem(.flexible()), count: 8)

  var body: some View {
    List {
      HStack {
        Spacer()
        Text("CheckerSpells")
          .font(.largeTitle)
          .bold()
          .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top))
        Spacer()
      }
      .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
      .listRowSeparator(.hidden)
      LazyVGrid(columns: columns, spacing: 0) {
        ForEach(0..<64) { index in
          let x = index % 8
          let y = index / 8
          ZStack {
            Rectangle()
              .fill((index / 8 + index % 8) % 2 == 0 ? Color.white : Color.brown)
              .frame(width: 40, height: 40)
              .border(Color.black)
            if let piece = pieces.first(where: { $0.isAtPosition(x: x, y: y) }) {
              PieceView(size: 30, color: piece.color)
            }
          }
        }
      }
      .northWestShadow(highlightColor: .black, shadowColor: .white)
      VStack(spacing: 16) {
        HStack(spacing: 16) {
          PieceView(size: 50, color: .lightPiece)
          Button {
              
          } label: {
              Text("Play Game")
              .frame(maxWidth: .infinity, maxHeight: 40)
          }
          .buttonStyle(MenuButtonStyle())
          PieceView(size: 50, color: Color.black)
        }
        HStack(spacing: 16) {
          PieceView(size: 50, color: .black)
          Button {
              
          } label: {
              Text("Instructions")
              .frame(maxWidth: .infinity, maxHeight: 40)
          }
          .buttonStyle(MenuButtonStyle())
          PieceView(size: 50, color: Color.lightPiece)
        }
        HStack(spacing: 16) {
          PieceView(size: 50, color: .lightPiece)
          Button {
              
          } label: {
              Text("Statistics")
              .frame(maxWidth: .infinity, maxHeight: 40)
          }
          .buttonStyle(MenuButtonStyle())
          PieceView(size: 50, color: Color.black)
        }
      }
      .listRowSeparator(.hidden)
      
    }
    .background(LinearGradient(gradient: Gradient(colors: [.black, .brown]), startPoint: .topLeading, endPoint: .bottomTrailing))
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  HomeView()
}
