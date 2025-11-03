//  AddMovieScreen.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import SwiftUI

struct AddMovieScreen: View {
    @Environment(MoviesVM.self) private var vm
        
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
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    vm.isShowingAddMovieScreen = false
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    vm.addMovie()
                }
                .disabled(!vm.isAddMovieFormValid())
            }
        }
    }
    
}


#Preview {
    NavigationStack {
        AddMovieScreen()
    }
    .modelContainer(.fakeContainer)
    .environment(MoviesVM(modelCtx: .fakeModelContext))
}
