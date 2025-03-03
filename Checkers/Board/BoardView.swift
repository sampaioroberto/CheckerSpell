import SwiftUI

struct BoardView: View {
  let size: CGSize
  let columns = Array(repeating: GridItem(.flexible()), count: 8)
  @StateObject var viewModel = BoardViewModel()
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 0) {
      ForEach(0..<64) { index in
        let x = index % 8
        let y = index / 8
        let currentPosition = GridPosition(x: x, y: y)
        ZStack {
          Rectangle()
            .fill((index / 8 + index % 8) % 2 == 0 ? Color.white : Color.brown)
            .frame(width: size.width/8, height: size.width/8)
          if let piece = viewModel.pieces.first(where: { $0.isAtPosition(x: x, y: y) }) {
            PieceView(size: size.width/10, color: piece.color)
          }
          if viewModel.selectedPosition == currentPosition {
            Color.green.opacity(0.2)
          }
          if viewModel.possibleMoves.contains(currentPosition) {
            PieceView(size: size.width/10, color: Color.green.opacity(0.2))
              .blur(radius: 1)
          }
        }
        .onTapGesture {
          viewModel.tapOn(x: x, y: y)
        }
      }
    }
    .frame(width: size.width, height: size.height)
    .northWestShadow(highlightColor: .black, shadowColor: .white)
  }
}

#Preview {
  BoardView(size: CGSize(width: 400, height: 400))
}
