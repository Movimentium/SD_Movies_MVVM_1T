//  MoviesVM.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import Foundation
import Observation
import SwiftData

@Observable @MainActor
final class MoviesVM {
    var title: String = ""
    var year: Int
    let years: [Int]
    var isShowingAddMovieScreen = false
    
    private let minYear = 1850
    private let maxYear = Calendar.current.component(.year, from: .now)
    private let modelCtx: ModelContext

    init(modelCtx: ModelContext) {
        self.modelCtx = modelCtx
        years = Array(minYear...maxYear)
        year = maxYear - 5
    }
    
    func setDefaultValues() {
        title = ""
        year = maxYear - 5
    }
    

    func isAddMovieFormValid() -> Bool {
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - DB methods
    func addMovie() {
        let newMovie = Movie(title: title, year: year)
        modelCtx.insert(newMovie)
        save()
        isShowingAddMovieScreen = false
    }
    
    private func save() {
        do {
            try modelCtx.save()
            print(Self.self, #function, "OK")
        } catch {
            print(Self.self, #function, "Error saving context: \(error)")
        }
    }

}
