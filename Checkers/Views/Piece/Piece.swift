import SwiftUI

struct Piece: Identifiable {
  let id = UUID()
  let color: Color
  let x: Int
  let y: Int
  
  func isAtPosition(x: Int, y: Int) -> Bool {
    self.x == x && self.y == y
  }
}
