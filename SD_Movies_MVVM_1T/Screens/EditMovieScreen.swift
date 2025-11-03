//  EditMovieScreen.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import SwiftUI

struct EditMovieScreen: View {
    @Environment(MoviesVM.self) private var vm
    @Environment(\.dismiss) private var dismiss
    let movie: Movie
    
    var body: some View {
        @Bindable var bindableVM = vm
        // This view is observing changes of vm in One Way (Read-Only)
        // with bindableVM we can changes values from here (Read-Write)

        Form {
            VStack(alignment: .leading, spacing: 8) {
                Text("Title").font(.headline)
                TextField("Title", text: $bindableVM.title)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Year").font(.headline)
                Picker("Year", selection: $bindableVM.year) {
                    ForEach(vm.years, id: \.self) { year in
                        Text(year.description) // No miles separators
                            .tag(year)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
        .navigationTitle("Edit Movie")
        .safeAreaInset(edge: .bottom) {
            Button {
                vm.movieToUpdate = movie
                vm.updateMovie()
                dismiss()
            } label: {
                Text("Update")
                    .font(.headline)
                    .padding(8)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 24)
        }
        .onAppear {
            bindableVM.title = movie.title
            bindableVM.year = movie.year
        }
    }
}

#Preview {
    NavigationStack {
        EditMovieScreen(movie: Movie.someMovies.first!)
    }
    .environment(MoviesVM(modelCtx: .fakeModelContext))

}
