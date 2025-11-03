//  SD_Movies_MVVM_1TApp.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import SwiftUI
import SwiftData

@main
struct SD_Movies_MVVM_1TApp: App {
    
    let modelContainer: ModelContainer
    let vm: MoviesVM
    
    init() {
        modelContainer = SDProvider().modelContainer
        vm = MoviesVM(modelContainer: self.modelContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AddMovieScreen()
            }
        }
        .modelContainer(modelContainer)
        .environment(vm)
    }
}
