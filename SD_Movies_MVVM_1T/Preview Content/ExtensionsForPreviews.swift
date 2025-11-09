//  ExtensionsForPreviews.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import Foundation
import SwiftData

extension SDProvider {
    
    static let previewMContainer: ModelContainer = {
        let schema = Schema([Movie.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true) // In memory <--
        let container = try! ModelContainer(for: schema, configurations: config)
        
        Movie.someMovies.forEach { container.mainContext.insert($0) }
        try! container.mainContext.save()
        
        return container
    }()
}

extension ModelContext {
    @MainActor
    static let fakeModelContext: ModelContext = SDProvider.previewMContainer.mainContext
}

extension ModelContainer {
    @MainActor
    static let fakeContainer: ModelContainer =  SDProvider.previewMContainer
}

extension Movie {
    
    static let someMovies: [Movie] = [
        .init(title: "Batman", year: 1989),
        .init(title: "Memento", year: 2000),
    ]

}
