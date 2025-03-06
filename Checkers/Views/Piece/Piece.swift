import SwiftUI

struct Piece: Hashable {
  let starterPlayer: Bool
  let position: GridPosition
  
  var color: Color {
    starterPlayer ? .lightPiece : .black
  }
  
  func validMoves(for pieces: Pieces) -> Set<Move> {
    let possibleMoves = possibleMoves(for: pieces)
    if possibleMoves.contains(where: { $0.isCapture }) {
      return possibleMoves
    } else {
      return pieces.containsCaptureMoveForOthersThan(self, starterPlayer: starterPlayer) ? [] : possibleMoves
    }
  }
  
  func possibleMoves(for pieces: Pieces) -> Set<Move> {
    let validMoves = Set([
      nextMove(at: starterPlayer ? .upLeft : .downLeft, on: pieces),
      nextMove(at: starterPlayer ? .upRight : .downRight, on: pieces),
      nextMove(at: starterPlayer ? .downLeft : .upLeft, on: pieces, shouldBeACapture: true),
      nextMove(at: starterPlayer ? .downRight : .downLeft, on: pieces, shouldBeACapture: true),
    ].compactMap({$0}))
    
    let captureMoves = validMoves.filter({ $0.isCapture })
    return captureMoves.isEmpty ? validMoves : captureMoves
  }
  
  func isAt(position: GridPosition) -> Bool {
    self.position == position
  }
}

private extension Piece {
  func nextMove(at direction: Direction, on pieces: Pieces, shouldBeACapture: Bool = false) -> Move? {
    guard let nextPosition = position.nextPosition(direction) else { return nil }
    guard let piece = pieces.first(where: { $0.position == nextPosition }) else {
      return shouldBeACapture ? nil : Move(destination: nextPosition)
    }
    guard piece.starterPlayer != starterPlayer,
          let positionAfterJump = piece.position.nextPosition(direction),
          !pieces.containsPiece(at: positionAfterJump) else { return nil }
      
    return Move(destination: positionAfterJump, capturePosition: nextPosition)
  }
}
