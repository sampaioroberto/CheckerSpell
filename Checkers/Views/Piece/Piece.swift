import SwiftUI

struct Piece: Identifiable, Hashable {
  let id = UUID()
  let starterPlayer: Bool
  let position: GridPosition
  
  var color: Color {
    starterPlayer ? .lightPiece : .black
  }
  
  func validMoves(for pieces: Pieces) -> Set<GridPosition> {
    (starterPlayer ? position.adjacents.filter({$0.y < position.y}) : position.adjacents.filter({$0.y > position.y}))
      .subtracting(pieces.map {$0.position} )
  }
  
  func isAt(position: GridPosition) -> Bool {
    self.position == position
  }
}
