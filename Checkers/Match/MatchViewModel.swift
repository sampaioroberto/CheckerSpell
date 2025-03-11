import SwiftUI

final class MatchViewModel: ObservableObject {
  @Published var pieces = Pieces.start
  @Published var selectedPosition: GridPosition?
  @Published var lastMovePositions = [GridPosition]()
  @Published var validMoves = [GridPosition]()
  @Published var isFirstPlayerTurn = true
  @Published var isEndGame = false
  private var isMultiCapturing = false
  
  func tapOn(position: GridPosition) {
    guard isEndGame == false else { return }
    if let selectedPosition {
      if let piece = pieces
        .filter({$0.starterPlayer == isFirstPlayerTurn})
        .first(where: { $0.isAt(position: position) }) {
        guard isMultiCapturing == false else { return }
        select(piece, at: position)
      } else {
        if let piece = pieces.first(where: { $0.isAt(position: selectedPosition) }),
           let movement = piece.validMoves(for: pieces).first(where: {$0.destination == position }) {
          move(piece, to: movement.destination)
          if let capturedPiece = pieces.first(where: { $0.position == movement.capturePosition}) {
            remove(capturedPiece)
            if let newPositionPiece = pieces.first(where: { $0.isAt(position: movement.destination) }),
                  newPositionPiece.validMoves(for: pieces).contains(where: { $0.isCapture }) {
              isMultiCapturing = true
              select(newPositionPiece, at: position)
            } else {
              changeTurn()
            }
          } else {
            changeTurn()
          }
        }
      }
    } else {
      if let piece = pieces
        .filter({$0.starterPlayer == isFirstPlayerTurn})
        .first(where: { $0.isAt(position: position) }) {
        select(piece, at: position)
      }
    }
  }
  
  func select(_ piece: Piece, at position: GridPosition) {
    selectedPosition = position
    withAnimation {
      validMoves = piece.validMoves(for: pieces).map({$0.destination})
    }
  }
  
  func clearSelection() {
    selectedPosition = nil
    validMoves = []
  }
  
  func move(_ piece: Piece, to position: GridPosition) {
    lastMovePositions = [piece.position, position]
    withAnimation {
      piece.move(to: position)
    }
  }
  
  func remove(_ piece: Piece) {
    withAnimation {
      pieces.removeAll(where: {$0.id == piece.id })
    }
  }
  
  func changeTurn() {
    clearSelection()
    isMultiCapturing = false
    
    pieces.forEach({$0.updateTypeIfNeeded()})
    
    let enemyPieces = pieces.filter({$0.starterPlayer != isFirstPlayerTurn})
    let noValidMoves = !enemyPieces.contains(where: { $0.validMoves(for: pieces).isNotEmpty })
    
    if noValidMoves {
      isEndGame = true
    } else {
      isFirstPlayerTurn.toggle()
    }
  }
}
