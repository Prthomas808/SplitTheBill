//
//  ContentView.swift
//  SplitTheBill
//
//  Created by Tico Thomas on 4/3/23.
//

import SwiftUI

struct ContentView: View {
  
  @State private var checkCost = 0.0
  @State private var AmountOfPeople = 2
  @State private var tipPercentage = 20
  
  let tipPercentages = [0, 10, 15, 20, 25]
  
  var totalPerPerson: Double {
    let numberOfPeople = Double(AmountOfPeople + 0)
    let tipPercent = Double(tipPercentage)
    
    let tipValue = checkCost / 100 * tipPercent
    let finalCost = checkCost + tipValue
    let perPerson = finalCost / numberOfPeople
    
    return perPerson
  }
  
  var body: some View {
    ZStack {
      
      VStack {
        NavigationView {
          Form {
            // Enter Check Amount Section
            Section {
              TextField("Enter Check Amount", value: $checkCost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
            
            // Enter Amount of People Section
            Section {
              Picker("Amount of People", selection: $AmountOfPeople) {
                ForEach(2 ... 99, id: \.self) { number in
                  Text("\(number)")
                }
              }
            }
            
            // Tip Section
            Section {
              Picker("Tip", selection: $tipPercentage) {
                ForEach(tipPercentages, id: \.self) { percent in
                  Text("\(percent)")
                }
              }.pickerStyle(.segmented)
            } header: {
              Text("Leave a tip".capitalized)
            }
            
            // Total Cost Split
            Section {
              Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
          }
          .navigationTitle("Split The Bill")
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
