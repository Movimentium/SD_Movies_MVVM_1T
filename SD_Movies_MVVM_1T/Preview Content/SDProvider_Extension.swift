//  SDProvider_Extension.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import Foundation
import SwiftData

extension SDProvider {
    
    static let previewMContainer: ModelContainer = {
        let schema = Schema([Movie.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true) // In memory <--
        let container = try! ModelContainer(for: schema, configurations: config)
        return container
    }()
}
