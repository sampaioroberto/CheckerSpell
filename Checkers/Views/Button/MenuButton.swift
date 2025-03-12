import SwiftUI

struct MenuButtonStyle: ButtonStyle {
  let cornerSize: Int
  let horizontalPadding: CGFloat
  
  init(cornerSize: Int = 8, horizontalPadding: CGFloat = 0) {
    self.cornerSize = cornerSize
    self.horizontalPadding = horizontalPadding
  }
  
  func makeBody(configuration: Self.Configuration)
  -> some View {
    configuration.label
      .padding(.horizontal, horizontalPadding)
      .opacity(configuration.isPressed ? 0.2 : 1)
      .foregroundStyle(Color.white)
      .bold()
      .background(
        Group {
          if configuration.isPressed {
            RoundedRectangle(cornerSize: CGSize(width: cornerSize, height: cornerSize))
              .fill(Color.brown)
              .blur(radius: 2)
          } else {
            RoundedRectangle(cornerSize: CGSize(width: cornerSize, height: cornerSize))
              .fill(Color.brown)
          }
        }
      )
  }
}
