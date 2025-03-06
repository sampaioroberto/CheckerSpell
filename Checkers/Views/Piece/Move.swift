struct Move: Hashable {
  let destination: GridPosition
  var capturePosition: GridPosition?
  
  var isCapture: Bool {
    capturePosition != nil
  }
}
