import SwiftUI

final class BoardViewModel: ObservableObject {
  @Published var pieces = Pieces.start
}
