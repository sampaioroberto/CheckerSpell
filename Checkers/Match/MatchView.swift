import SwiftUI

struct MatchView: View {
  @StateObject var viewModel = MatchViewModel()
  var body: some View {
    GeometryReader { proxy in
      VStack {
        HStack {
          Text(viewModel.isEndGame ? "Winner:": "Turn:")
          PieceView(
            size: 20,
            color: Piece.color(
              starterPlayer: viewModel.isFirstPlayerTurn
            ),
            type: .default
          )
        }
        Spacer()
        BoardView(size: proxy.size, viewModel: viewModel)
        Spacer()
      }
    }
  }
}

#Preview {
  MatchView(viewModel: MatchViewModel())
}
