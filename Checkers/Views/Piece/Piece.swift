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

typealias Pieces = [Piece]

extension Array where Element == Piece {
  static let start: [Piece] = {
    [
      Piece(color: .black, x: 1, y: 0),
      Piece(color: .black, x: 3, y: 0),
      Piece(color: .black, x: 5, y: 0),
      Piece(color: .black, x: 7, y: 0),
      Piece(color: .black, x: 0, y: 1),
      Piece(color: .black, x: 2, y: 1),
      Piece(color: .black, x: 4, y: 1),
      Piece(color: .black, x: 6, y: 1),
      Piece(color: .black, x: 1, y: 2),
      Piece(color: .black, x: 3, y: 2),
      Piece(color: .black, x: 5, y: 2),
      Piece(color: .black, x: 7, y: 2),
      Piece(color: Color.lightPiece, x: 0, y: 7),
      Piece(color: Color.lightPiece, x: 2, y: 7),
      Piece(color: Color.lightPiece, x: 4, y: 7),
      Piece(color: Color.lightPiece, x: 6, y: 7),
      Piece(color: Color.lightPiece, x: 1, y: 6),
      Piece(color: Color.lightPiece, x: 3, y: 6),
      Piece(color: Color.lightPiece, x: 5, y: 6),
      Piece(color: Color.lightPiece, x: 7, y: 6),
      Piece(color: Color.lightPiece, x: 0, y: 5),
      Piece(color: Color.lightPiece, x: 2, y: 5),
      Piece(color: Color.lightPiece, x: 4, y: 5),
      Piece(color: Color.lightPiece, x: 6, y: 5)
    ]
  }()
}
