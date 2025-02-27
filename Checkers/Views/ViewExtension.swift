import SwiftUI

extension View {
  func northWestShadow(
    highlightColor: Color,
    shadowColor: Color,
    radius: CGFloat = 2,
    offset: CGFloat = 0.5
  ) -> some View {
        return self
            .shadow(color: highlightColor, radius: radius, x: -offset, y: -offset)
            .shadow(color: shadowColor, radius: radius, x: offset, y: offset)
    }
    
    func southEastShadow(
      highlightColor: Color,
      shadowColor: Color,
      radius: CGFloat = 4,
      offset: CGFloat = 1
    ) -> some View {
        return self
            .shadow(color: shadowColor, radius: radius, x: -offset, y: -offset)
            .shadow(color: highlightColor, radius: radius, x: offset, y: offset)
    }
}
