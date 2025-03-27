
import SwiftUI
import WebKit

struct ArticleWebView: View {
    let urlString: String
//    let selectedaUUID: UUID
    let selectedArticle: Article?
    @State private var showSavedMessage = false

    var body: some View {
        ZStack {
            if let validURL = URL(string: urlString) {
                WebView(url: validURL)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Invalid URL")
                    .foregroundColor(.red)
                    .font(.headline)
            }
           
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        saveArticleToCoreData()
                        showSavedMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSavedMessage = false
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
            
            if showSavedMessage {
                VStack {
                    Spacer()
                    Text("Article Saved!")
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 80)
                }
                .transition(.slide)
            }
        }
        .navigationTitle("Full Article")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveArticleToCoreData() {
        CoreDataManager.shared.saveArticle(url: selectedArticle?.url ?? "", uID: selectedArticle?.id ?? UUID(), title: selectedArticle?.title ?? "", description: selectedArticle?.description ?? "", urlToImage: selectedArticle?.urlToImage ?? "")
    }
}

#Preview {
    ArticleWebView(urlString: "https://www.google.com/",selectedArticle: Article(title: "jlll", description: "jjjj", url: "nnd", urlToImage: "dd", id: UUID()))
}
