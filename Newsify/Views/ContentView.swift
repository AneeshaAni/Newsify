import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("Home")
                        .tint(.cyan)
                }
                .navigationBarBackButtonHidden(true)

            SavedListView()
                .tabItem {
                    Text("Saved")
                        .tint(.cyan)
                }
        }
        .accentColor(.cyan)
      
    }
}

#Preview {
    ContentView()
}
