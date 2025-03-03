import SwiftUI

final class BoardViewModel: ObservableObject {
  @Published var pieces = Pieces.start
  @Published var selectedPosition: GridPosition?
  @Published var possibleMoves = Set<GridPosition>()
  
  func tapOn(x: Int, y: Int) {
    if selectedPosition != GridPosition(x: x, y: y), let piece = pieces.first(where: { $0.isAtPosition(x: x, y: y)}) {
      selectedPosition = GridPosition(x: x, y: y)
      displayPossibleMoves(piece: piece)
    } else {
      selectedPosition = nil
      clearPossibleMoves()
    }
  }
  
  func displayPossibleMoves(piece: Piece) {
    let moves = piece.starterPlayer ? piece.position.adjacents.filter({$0.y < piece.position.y}) : piece.position.adjacents.filter({$0.y > piece.position.y})
    possibleMoves = moves.subtracting(pieces.map{$0.position})
  }
  
  func clearPossibleMoves() {
    possibleMoves = []
  }
}
