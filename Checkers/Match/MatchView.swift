import SwiftUI

struct MatchView: View {
  var body: some View {
    GeometryReader { proxy in
      BoardView(size: proxy.size)
    }
  }
}

#Preview {
  MatchView()
}
