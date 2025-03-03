struct GridPosition: Equatable, Hashable {
  let x: Int
  let y: Int
  
  var adjacents: Set<GridPosition> {
    var moves = Set<GridPosition>()
    if y-1 >= 0 {
      if x-1 >= 0 {
        moves.insert(GridPosition(x: x-1, y: y-1))
      }
      if x+1 <= 8 {
        moves.insert(GridPosition(x: x+1, y: y-1))
      }
    }
    if y+1 <= 8 {
      if x-1 >= 0 {
        moves.insert(GridPosition(x: x-1, y: y+1))
      }
      if x+1 <= 8 {
        moves.insert(GridPosition(x: x+1, y: y+1))
      }
    }
    return moves
  }
}
