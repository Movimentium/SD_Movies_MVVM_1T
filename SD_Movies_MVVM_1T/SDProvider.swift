//  SDProvider.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import Foundation
import SwiftData

@MainActor
class SDProvider {
    let modelContainer: ModelContainer
    let modelCtx: ModelContext
    
    init() {
        let schema = Schema([Movie.self])
        let config = ModelConfiguration("SDMoviesDB", schema: schema)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: config)
            modelCtx = modelContainer.mainContext
        } catch {
            fatalError("\(Self.self) \(#function) ModelContainer could NOT be initialized: \(error)")
        }
    }
    
}
