//
//  PickerView.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
import SwiftUI
import SwiftData


struct PickerView: View {
    @State private var selectedAge = 27
    let ageRange = Array(1...99)
    
    var body: some View {
        VStack {
            HStack {
                Text("Alter:")
                    .font(.title2)
                    .padding(.top, 0)
                    .foregroundStyle(.gray.gradient)
                    .shadow(radius: 3).contrast(3)
                Picker("Alter", selection: $selectedAge) {
                    ForEach(ageRange, id: \.self) { num in
                        Text("\(num) Jahre")
                            .tag(num)
                            .foregroundStyle(.gray)
                            .shadow(radius: 3).contrast(3)
                    }
                }
              //  .font(.custom("comfortaa.ttf", size: 20))
            }
            .frame(height: 100)
            .pickerStyle(.wheel)
            .clipped()
            .padding()
            Text("Dein Alter: \(selectedAge) Jahre")
                .font(.headline)
                .padding(.top, 10)
                .foregroundStyle(.gray.gradient)
                .shadow(radius: 3).contrast(3)
        }
    }
}

#Preview {
    PickerView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
}
