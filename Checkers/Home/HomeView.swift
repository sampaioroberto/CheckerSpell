import SwiftUI

struct HomeView: View {
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.black, .brown]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
      VStack {
        HStack {
          Spacer()
          Text("CheckerSpells")
            .font(.largeTitle)
            .bold()
            .foregroundStyle(Color.white)
          Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
        GeometryReader { proxy in
          BoardView(size: proxy.size)
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        VStack(spacing: 16) {
          HStack(spacing: 16) {
            PieceView(size: 50, color: .lightPiece, type: .default)
            NavigationLink(destination: {
              MatchView()
            }, label: {
              Text("Play Game")
                .frame(maxWidth: .infinity, maxHeight: 40)
            })
            
            PieceView(size: 50, color: Color.black, type: .default)
          }
          HStack(spacing: 16) {
            PieceView(size: 50, color: .black, type: .king)
            Button {
              
            } label: {
              Text("Instructions")
                .frame(maxWidth: .infinity, maxHeight: 40)
            }
            .buttonStyle(MenuButtonStyle())
            PieceView(size: 50, color: Color.lightPiece, type: .king)
          }
          HStack(spacing: 16) {
            PieceView(size: 50, color: .lightPiece, type: .default)
            Button {
              
            } label: {
              Text("Statistics")
                .frame(maxWidth: .infinity, maxHeight: 40)
            }
            .buttonStyle(MenuButtonStyle())
            PieceView(size: 50, color: Color.black, type: .default)
          }
        }
      }
      .padding(16)
      .background(Color.white)
      .clipShape(.rect(cornerRadius: 16))
      .padding(16)
    }
    
  }
}

#Preview {
  HomeView()
}
