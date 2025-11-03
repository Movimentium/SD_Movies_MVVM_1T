//  AddMovieScreen.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import SwiftUI

struct AddMovieScreen: View {
    @Environment(MoviesVM.self) private var vm
    @Environment(\.dismiss) private var dismiss
        
    var body: some View {
        Form {
            @Bindable var bindableVM = vm
            // This view is observing changes of vm in One Way (Read-Only)
            // with bindableVM we can changes values from here (Read-Write)
            VStack(alignment: .leading, spacing: 8) {
                Text("Title").font(.headline)
                TextField("Title", text: $bindableVM.title)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Year").font(.headline)
                Picker("Year", selection: $bindableVM.year) {
                    ForEach(vm.years, id: \.self) { year in
                        Text("\(year)")
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
                    dismiss()
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
    .environment(MoviesVM())
}
