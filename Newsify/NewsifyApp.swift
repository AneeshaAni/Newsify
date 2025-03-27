//
//  NewsifyApp.swift
//  Newsify
//
//  Created by Aneesha on 26/03/25.
//

import SwiftUI

@main
struct NewsifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BaseView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
