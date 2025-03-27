
import SwiftUI

struct BaseView: View {
    
    @State private var textOffset: CGFloat = -300
    @State private var navigateToSetTimeView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("newsbg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                LinearGradient(colors: [.green.opacity(0.4), .blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Welcome to NewsifyApp")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 10, x: 0, y: 3)
                        .padding()
                        .offset(y: textOffset)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.5)) {
                                textOffset = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                navigateToSetTimeView = true
                            }
                        }
                    
                }
            }
            .navigationDestination(isPresented: $navigateToSetTimeView) {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
