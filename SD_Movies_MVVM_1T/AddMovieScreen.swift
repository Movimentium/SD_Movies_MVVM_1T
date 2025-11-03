//  AddMovieScreen.swift
//  SD_Movies_MVVM_1T
//  Created by Miguel Gallego on 3/11/25.
import SwiftUI

struct AddMovieScreen: View {
    
    @State private var vm = MoviesVM()
    
    @State private var selectedDate = Date()
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 8) {
                Text("Title").font(.headline)
                TextField("Title", text: $vm.title)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Year").font(.headline)
                Picker("Year", selection: $vm.year) {
                    ForEach(vm.years, id: \.self) { year in
                        Text("\(year)")
                            .tag(year)
                    }
                }
                .pickerStyle(.wheel)
                
            }
            
        }
        .navigationTitle("Add Movie")
    }
}


#Preview {
    NavigationStack {
        AddMovieScreen()
    }
}
