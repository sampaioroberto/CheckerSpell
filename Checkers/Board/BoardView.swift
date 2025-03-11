import SwiftUI

struct BoardView: View {
  let size: CGSize
  let columns = Array(repeating: GridItem(.flexible()), count: 8)
  @StateObject var viewModel = BoardViewModel()
  
  var body: some View {
    ZStack {
      ForEach(0..<8) { y in
        ForEach(0..<8) { x in
          let position = GridPosition(x: x, y: y)
          Rectangle()
            .fill((x + y) % 2 == 0 ? Color.white : Color.brown)
            .frame(width: size.width/8, height: size.width/8)
            .position(
              x: CGFloat(x) * (size.width / 8) + (size.width / 16),
              y: CGFloat(y) * (size.width / 8) + (size.width / 16)
            )
            .onTapGesture {
              viewModel.tapOn(position: position)
            }
          
          if viewModel.validMoves.contains(position) {
            PieceView(size: size.width/10, color: Color.green.opacity(0.2), type: .default)
              .blur(radius: 1)
              .position(
                x: CGFloat(position.x) * (size.width / 8) + (size.width / 16),
                y: CGFloat(position.y) * (size.width / 8) + (size.width / 16)
              )
              
          }
        }
      }
      
      ForEach(viewModel.pieces) { piece in
        PieceView(size: size.width/10, color: piece.color, type: piece.type)
          .position(
            x: CGFloat(piece.position.x) * (size.width / 8) + (size.width / 16),
            y: CGFloat(piece.position.y) * (size.width / 8) + (size.width / 16)
          )
          .transition(.opacity)
          .zIndex(1)
          .animation(.easeInOut(duration: 0.3), value: piece.position)
          
      }
      
      if let selectedPosition = viewModel.selectedPosition {
        Color.green.opacity(0.2)
          .frame(width: size.width/8, height: size.width/8)
          .position(
            x: CGFloat(selectedPosition.x) * (size.width / 8) + (size.width / 16),
            y: CGFloat(selectedPosition.y) * (size.width / 8) + (size.width / 16)
          )
      }
    }
    .frame(width: size.width, height: size.height)
    .northWestShadow(highlightColor: .black, shadowColor: .white)
  }
}

#Preview {
  BoardView(size: CGSize(width: 400, height: 400))
}
