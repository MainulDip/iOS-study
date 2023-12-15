//
//  ContentView.swift
//  BetterRest-4
//
//  Created by Mainul Dip on 12/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 7.0
    @State private var celsius: Double = 0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack(){
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            Spacer().frame(height: 30)
            
            Slider(value: $celsius, in: -100...100)
                        Text("\(celsius, specifier: "%.1f") Celsius is \(celsius * 9 / 5 + 32, specifier: "%.1f") Fahrenheit")
//            DatePicker("Please enter a time",
//                       selection: $wakeUp, // two way binding
//                       in: Date.now..., // prevent form selecting past date
//                       displayedComponents: .hourAndMinute // display options for the picker
//            )
//                .labelsHidden() // screen readers can also listen the label
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
