import SwiftUI

struct MatchView: View {
  @StateObject var viewModel = MatchViewModel()
  @Binding var showGameScreen: Bool
  @State var showAlertExitConfirmation = false
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
          Spacer()
          Menu {
            Button("Exit Game", action: { showAlertExitConfirmation = true })
            Button("Restart", action: { viewModel.restartGame() })
            Button("Continue", action: { })
          } label: {
            Label("Options", systemImage: "gearshape")
          }
          .foregroundStyle(Color.black)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.brown)
        Spacer()
        BoardView(size: proxy.size, viewModel: viewModel)
        Spacer()
      }
    }
    .alert( isPresented: $showAlertExitConfirmation) {
      Alert(
        title: Text("Exit Game?"),
        message: Text("Are you sure you want to leave the match?"),
        primaryButton: .destructive(
          Text("Quit Game"),
          action: { showGameScreen = false }
        ),
        secondaryButton: .cancel(Text("Stay"))
        )
    }
  }
}

#Preview {
  @Previewable @State var showGameScreen = true
  MatchView(viewModel: MatchViewModel(), showGameScreen: $showGameScreen)
}
