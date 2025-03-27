import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Newsify")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveArticle(url: String, uID: UUID, title: String, description: String, urlToImage: String) {
        let context = persistentContainer.viewContext
        let article = SavedArticle(context: context)
        article.url = url
        article.dateSaved = Date()
        article.id = uID
        article.title = title
        article.des = description
        article.urlToImage = urlToImage
        
        do {
            try context.save()
            
            print("Article saved to Core Data \(String(describing: article.id) )")
        } catch {
            print("Failed to save article: \(error.localizedDescription)")
        }
    }
    
    func fetchSavedArticles() -> [SavedArticle] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        
        do {
            let savedArticles = try context.fetch(fetchRequest)
            print("Fetched \(savedArticles.count) articles from Core Data")
            return savedArticles
        } catch {
            print("Failed to fetch articles: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteArticle(_ article: SavedArticle) {
        let context = persistentContainer.viewContext
        context.delete(article)
        
        do {
            try context.save()
            print("Article deleted successfully")
        } catch {
            print("Failed to delete article: \(error.localizedDescription)")
        }
    }


}
