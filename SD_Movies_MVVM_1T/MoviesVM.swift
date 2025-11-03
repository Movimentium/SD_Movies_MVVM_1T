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
    var movieToUpdate: Movie?
    var isShowingAddMovieScreen = false {
        willSet {
            if newValue { setDefaultValues() }
        }
    }

    private let minYear = 1850
    private let maxYear = Calendar.current.component(.year, from: .now)
    private let modelCtx: ModelContext

    init(modelCtx: ModelContext) {
        self.modelCtx = modelCtx
        years = Array(minYear...maxYear)
        year = maxYear - 5
    }
    
    private func setDefaultValues() {
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
        let title = title.trimmingCharacters(in: .whitespaces)
        let newMovie = Movie(title: title, year: year)
        modelCtx.insert(newMovie)
        save()
        isShowingAddMovieScreen = false
    }
    
    func deleteMovie(_ movie: Movie) {
        modelCtx.delete(movie)
        save()
    }
    
    func updateMovie() {
        guard let movie = movieToUpdate else { return }
        movie.title = title.trimmingCharacters(in: .whitespaces)
        movie.year = year
        save()
    }
    
    private func save() {
        do {
            try modelCtx.save()
            print(Self.self, #function, "OK")
        } catch {
            print(Self.self, #function, "Error saving context: \(error)")
        }
    }
    
    private func debug_printMovie(_ movie: Movie) {
        print(#function, "Title: \(title), Year: \(year)")
    }

}
