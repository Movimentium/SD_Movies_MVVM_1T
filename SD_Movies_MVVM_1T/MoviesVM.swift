//  MoviesVM.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import Foundation
import Observation

@Observable final class MoviesVM {
    var title: String = ""
    var year: Int
    let years: [Int]
    
    private let minYear = 1850
    private let maxYear = Calendar.current.component(.year, from: .now)

    init() {
        years = Array(minYear...maxYear)
        year = maxYear - 5
    }
    
    func setDefaultValues() {
        title = ""
        year = maxYear - 5
    }
}
