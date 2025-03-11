import SwiftUI

enum PieceType {
  case `default`
  case king
}

final class Piece: Identifiable {
  let id = UUID()
  var position: GridPosition
  
  let starterPlayer: Bool
  var type: PieceType
  
  var color: Color {
    Piece.color(starterPlayer: starterPlayer)
  }
  
  init(starterPlayer: Bool, position: GridPosition, type: PieceType = .default) {
    self.position = position
    self.starterPlayer = starterPlayer
    self.type = type
  }
  
  func validMoves(for pieces: Pieces) -> [Move] {
    let possibleMoves = possibleMoves(for: pieces)
    if possibleMoves.contains(where: { $0.isCapture }) {
      return possibleMoves
    } else {
      return pieces.containsCaptureMoveForOthersThan(self, starterPlayer: starterPlayer) ? [] : possibleMoves
    }
  }
  
  func possibleMoves(for pieces: Pieces) -> [Move] {
    switch type {
    case .default: return possibleDefaultMoves(for: pieces)
    case .king: return possibleKingMoves(for: pieces)
    }
  }
  
  private func possibleDefaultMoves(for pieces: Pieces) -> [Move] {
    let validMoves = [
      nextMove(at: starterPlayer ? .upLeft : .downLeft, on: pieces),
      nextMove(at: starterPlayer ? .upRight : .downRight, on: pieces),
      nextMove(at: starterPlayer ? .downLeft : .upLeft, on: pieces, shouldBeACapture: true),
      nextMove(at: starterPlayer ? .downRight : .upRight, on: pieces, shouldBeACapture: true)
    ].compactMap({$0})
    
    let captureMoves = validMoves.filter({ $0.isCapture })
    return captureMoves.isEmpty ? validMoves : captureMoves
  }
  
  private func possibleKingMoves(for pieces: Pieces) -> [Move] {
    let validMoves = fourDirectionKingMoves(from: position, for: pieces)
    
    let captureMoves = validMoves.filter({ $0.isCapture })
    let destinationWithNextCaptureMoves = captureMoves.filter { captureMove in
      fourDirectionKingMoves(
        from: captureMove.destination,
        for: pieces.filter({$0.position != captureMove.capturePosition}))
      .contains(where: {$0.isCapture})
    }
    
    return destinationWithNextCaptureMoves.isEmpty ? captureMoves.isEmpty ? validMoves : captureMoves : destinationWithNextCaptureMoves
  }
  
  private func fourDirectionKingMoves(from position: GridPosition, for pieces: Pieces) -> [Move] {
    return nextMoves(from: position, at: .upLeft, on: pieces) +
    nextMoves(from: position, at: .upRight, on: pieces) +
    nextMoves(from: position, at: .downLeft, on: pieces) +
    nextMoves(from: position, at: .downRight, on: pieces)
  }
  
  func isAt(position: GridPosition) -> Bool {
    self.position == position
  }
  
  func move(to position: GridPosition) {
    self.position = position
  }
  
  func updateTypeIfNeeded() {
    if isAtTheEnd {
      type = .king
    }
  }
  
  private var isAtTheEnd: Bool {
    starterPlayer ? position.y == 0 : position.y == 7
  }
}

extension Piece: Equatable {
  static func == (lhs: Piece, rhs: Piece) -> Bool {
    return lhs.id == rhs.id
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
  
  func nextMoves(from position: GridPosition, at direction: Direction, on pieces: Pieces) -> [Move] {
    var validMoves = [Move]()
    var nextPosition = position.nextPosition(direction)
    var capturePosition: GridPosition?
    while(nextPosition != nil) {
      guard let piece = pieces.first(where: {$0.position == nextPosition}) else {
        guard let unwrappedNextPosition = nextPosition else { return [] }
        validMoves.append(Move(destination: unwrappedNextPosition, capturePosition: capturePosition))
        nextPosition = nextPosition?.nextPosition(direction)
        continue
      }
      guard piece.starterPlayer != starterPlayer,
            let positionAfterJump = piece.position.nextPosition(direction),
            !pieces.containsPiece(at: positionAfterJump),
            capturePosition == nil else {
        return validMoves
      }
      validMoves.append(Move(destination: positionAfterJump, capturePosition: nextPosition))
      capturePosition = nextPosition
      nextPosition = positionAfterJump
    }
    return validMoves
  }
}

extension Piece {
  static func color(starterPlayer: Bool) -> Color {
    starterPlayer ? .lightPiece : .black
  }
}
