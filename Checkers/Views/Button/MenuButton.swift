import SwiftUI

struct MenuButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration)
  -> some View {
    configuration.label
      .opacity(configuration.isPressed ? 0.2 : 1)
      .foregroundStyle(Color.white)
      .bold()
      .background(
        Group {
          if configuration.isPressed {
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
              .fill(Color.brown)
              .blur(radius: 2)
          } else {
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
              .fill(Color.brown)
          }
        }
      )
  }
}
