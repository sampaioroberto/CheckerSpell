import SwiftUI

struct Piece: Identifiable {
  let id = UUID()
  let starterPlayer: Bool
  let position: GridPosition
  
  var color: Color {
    starterPlayer ? .lightPiece : .black
  }
  
  func isAtPosition(x: Int, y: Int) -> Bool {
    position.x == x && position.y == y
  }
}

typealias Pieces = [Piece]

extension Array where Element == Piece {
  static let start: [Piece] = {
    [
      Piece(starterPlayer: false, position: GridPosition(x: 1, y: 0)),
      Piece(starterPlayer: false, position: GridPosition(x: 3, y: 0)),
      Piece(starterPlayer: false, position: GridPosition(x: 5, y: 0)),
      Piece(starterPlayer: false, position: GridPosition(x: 7, y: 0)),
      Piece(starterPlayer: false, position: GridPosition(x: 0, y: 1)),
      Piece(starterPlayer: false, position: GridPosition(x: 2, y: 1)),
      Piece(starterPlayer: false, position: GridPosition(x: 4, y: 1)),
      Piece(starterPlayer: false, position: GridPosition(x: 6, y: 1)),
      Piece(starterPlayer: false, position: GridPosition(x: 1, y: 2)),
      Piece(starterPlayer: false, position: GridPosition(x: 3, y: 2)),
      Piece(starterPlayer: false, position: GridPosition(x: 5, y: 2)),
      Piece(starterPlayer: false, position: GridPosition(x: 7, y: 2)),
      Piece(starterPlayer: true, position: GridPosition(x: 0, y: 7)),
      Piece(starterPlayer: true, position: GridPosition(x: 2, y: 7)),
      Piece(starterPlayer: true, position: GridPosition(x: 4, y: 7)),
      Piece(starterPlayer: true, position: GridPosition(x: 6, y: 7)),
      Piece(starterPlayer: true, position: GridPosition(x: 1, y: 6)),
      Piece(starterPlayer: true, position: GridPosition(x: 3, y: 6)),
      Piece(starterPlayer: true, position: GridPosition(x: 5, y: 6)),
      Piece(starterPlayer: true, position: GridPosition(x: 7, y: 6)),
      Piece(starterPlayer: true, position: GridPosition(x: 0, y: 5)),
      Piece(starterPlayer: true, position: GridPosition(x: 2, y: 5)),
      Piece(starterPlayer: true, position: GridPosition(x: 4, y: 5)),
      Piece(starterPlayer: true, position: GridPosition(x: 6, y: 5))
    ]
  }()
}
