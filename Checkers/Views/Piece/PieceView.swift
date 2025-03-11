import SwiftUI

struct PieceView: View {
  var size: CGFloat
  var color: Color
  var type: PieceType
  @State private var showKing = false // Adicionada variável para controlar a exibição do ícone

  var body: some View {
    ZStack {
      Circle()
        .fill(color)
        .northWestShadow(highlightColor: color, shadowColor: .white)
        .frame(width: size)
      Circle()
        .foregroundStyle(color)
        .frame(width: size)
        .northWestShadow(highlightColor: Color.black, shadowColor: .white)
        .opacity(0.8)
      Circle()
        .foregroundStyle(color)
        .frame(width: size*0.75)
        .opacity(0.5)
      Circle()
        .foregroundStyle(color)
        .frame(width: size*0.2)
        .opacity(0.6)
        .northWestShadow(highlightColor: Color.black, shadowColor: .white, radius: 2, offset: 0.5)
      if type == .king {
        ZStack {
          Circle()
            .foregroundStyle(Color.yellow)
            .frame(width: size*0.5)
          Image(systemName: "crown")
            .resizable()
            .scaledToFit()
            .frame(width: size*0.4)
            .foregroundStyle(Color.black)
        }
        .opacity(showKing ? 1 : 0)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showKing = true
          }
        }
      }
    }
  }
}
