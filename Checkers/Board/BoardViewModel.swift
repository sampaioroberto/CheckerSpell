import SwiftUI

final class BoardViewModel: ObservableObject {
  @Published var pieces = Pieces.start
  @Published var selectedPosition: GridPosition?
  @Published var validMoves = Set<GridPosition>()
  private var starterPlayerTurn = true
  
  func tapOn(position: GridPosition) {
    if let selectedPosition {
      if let piece = pieces
        .filter({$0.starterPlayer == starterPlayerTurn})
        .first(where: { $0.isAt(position: position) }) {
        select(piece, at: position)
      } else {
        if let piece = pieces.first(where: { $0.isAt(position: selectedPosition) }),
           let move = piece.validMoves(for: pieces).first(where: {$0.destination == position }) {
          movePiece(piece, to: move.destination)
          if let capturedPiece = pieces.first(where: { $0.position == move.capturePosition}) {
            pieces.remove(capturedPiece)
          }
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
    validMoves = Set(piece.validMoves(for: pieces).map({$0.destination}))
  }
  
  func clearSelection() {
    selectedPosition = nil
    validMoves = []
  }
  
  func movePiece(_ piece: Piece, to position: GridPosition) {
    pieces.remove(piece)
    let newPositionPiece = Piece(starterPlayer: piece.starterPlayer, position: position)
    pieces.insert(newPositionPiece)
    clearSelection()
    starterPlayerTurn.toggle()
  }
}
