import SwiftUI

final class BoardViewModel: ObservableObject {
  @Published var pieces = Pieces.start
  @Published var selectedPosition: GridPosition?
  @Published var possibleMoves = Set<GridPosition>()
  private var starterPlayerTurn = true
  
  func tapOn(position: GridPosition) {
    if let selectedPosition {
      if let piece = pieces
        .filter({$0.starterPlayer == starterPlayerTurn})
        .first(where: { $0.isAt(position: position) }) {
        select(piece, at: position)
      } else {
        if let piece = pieces.first(where: { $0.isAt(position: selectedPosition) }),
            piece.validMoves(for: pieces).contains(position) {
          move(piece, to: position)
        }
      }
    } else {
      if let piece = pieces
        .filter({$0.starterPlayer == starterPlayerTurn})
        .first(where: { $0.isAt(position: position) }) {
        select(piece, at: position)
      }
    }
  }
  
  func select(_ piece: Piece, at position: GridPosition) {
    selectedPosition = position
    possibleMoves = piece.validMoves(for: pieces)
  }
  
  func clearSelection() {
    selectedPosition = nil
    possibleMoves = []
  }
  
  func move(_ piece: Piece, to position: GridPosition) {
    pieces.remove(piece)
    let newPositionPiece = Piece(starterPlayer: piece.starterPlayer, position: position)
    pieces.insert(newPositionPiece)
    clearSelection()
    starterPlayerTurn.toggle()
  }
}
