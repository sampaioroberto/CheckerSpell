enum Direction {
  case upLeft
  case upRight
  case downLeft
  case downRight
}

struct GridPosition: Equatable, Hashable {
  let x: Int
  let y: Int
  
  func nextPosition(_ direction: Direction) -> GridPosition? {
    switch direction {
    case .upLeft: return y-1 >= 0 && x-1 >= 0 ? GridPosition(x: x-1, y: y-1) : nil
    case .upRight: return y-1 >= 0 && x+1 <= 7 ? GridPosition(x: x+1, y: y-1) : nil
    case .downLeft: return y+1 <= 7 && x-1 >= 0 ? GridPosition(x: x-1, y: y+1) : nil
    case .downRight: return y+1 <= 7 && x+1 <= 7 ? GridPosition(x: x+1, y: y+1) : nil
    }
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}
