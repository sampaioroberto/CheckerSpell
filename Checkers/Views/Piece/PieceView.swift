import SwiftUI

struct PieceView: View {
  var size: CGFloat
  var color: Color
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
    }
  }
}
