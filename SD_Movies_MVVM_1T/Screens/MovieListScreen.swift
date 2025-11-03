//  MovieListScreen.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import SwiftUI
import SwiftData

struct MovieListScreen: View {
    @Environment(MoviesVM.self) private var vm
    @Query private var movies: [Movie]
    
    var body: some View {
        @Bindable var bindableVM = vm
        
        List {
            ForEach(movies) { movie in  //TODO: navlink to edit
                NavigationLink(value: movie){
                    HStack {
                        Text(movie.title)
                        Spacer() 
                        Text(movie.year.description) // No miles separators
                    }
                }
            }
            .onDelete { $0.forEach { vm.deleteMovie(movies[$0]) } }
        }
        .navigationTitle("Movies")
        .navigationDestination(for: Movie.self) { movie in
            EditMovieScreen(movie: movie)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    vm.isShowingAddMovieScreen = true
                }
            }
        }
        .sheet(isPresented: $bindableVM.isShowingAddMovieScreen) {
            NavigationStack {
                AddMovieScreen()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
    }
    .modelContainer(.fakeContainer)
    .environment(MoviesVM(modelCtx: .fakeModelContext))
}
