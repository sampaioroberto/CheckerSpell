import SwiftUI

@MainActor
final class MatchViewModel: ObservableObject {
  @Published var pieces = Pieces.start
  @Published var selectedPosition: GridPosition?
  @Published var lastMovePositions = [GridPosition]()
  @Published var validMoves = [GridPosition]()
  @Published var isFirstPlayerTurn = true
  @Published var isEndGame = false
  let isVsComputer: Bool
  private var isMultiCapturing = false
  private var computerTask: Task<Void, Never>?

  init(isVsComputer: Bool = false) {
    self.isVsComputer = isVsComputer
  }

  func tapOn(position: GridPosition) {
    guard isEndGame == false else { return }
    guard isFirstPlayerTurn || !isVsComputer else { return }
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

  private func computerMove(_ piece: Piece, to position: GridPosition) async {
    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
    lastMovePositions = [piece.position, position]
    withAnimation {
      piece.move(to: position)
    }
  }

  private func computerRemove(_ piece: Piece) async {
    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
    withAnimation {
      pieces.removeAll(where: { $0.id == piece.id })
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
      if isVsComputer {
        computerTask = Task {
          await checkComputerTurn()
        }
      }
    }
  }

  private func checkComputerTurn() async {
    guard !Task.isCancelled else { return }
    guard !isFirstPlayerTurn else { return }

    let computerPieces = pieces.filter({$0.starterPlayer == false})
    let validPieces = computerPieces.filter({ $0.validMoves(for: pieces).isNotEmpty })

    guard let piece = validPieces.randomElement() else { return }
    let validMoves = piece.validMoves(for: pieces)
    guard let movement = validMoves.randomElement() else { return }
    await computerMove(piece, to: movement.destination)

    if movement.isCapture {
      if let capturedPiece = pieces.first(where: { $0.position == movement.capturePosition }) {
        await computerRemove(capturedPiece)
      }
      while let newMove = piece.validMoves(for: pieces).first(where: { $0.isCapture }) {
        await computerMove(piece, to: newMove.destination)
        if let capturedPiece = pieces.first(where: { $0.position == newMove.capturePosition }) {
          await computerRemove(capturedPiece)
        }
      }
    }
    changeTurn()
  }

  func restartGame() {
    computerTask?.cancel()
    computerTask = nil
    pieces = Pieces.start
    isFirstPlayerTurn = true
    clearSelection()
    isMultiCapturing = false
    isEndGame = false
    validMoves = []
    lastMovePositions = []
  }
}
