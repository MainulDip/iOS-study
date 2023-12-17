//
//  ContentView.swift
//  BetterRest-4
//
//  Created by Mainul Dip on 12/14/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    // state for alerting
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    // computed property for defaultWakeTime
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.lightGray)
                    .brightness(0.27)
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    HStack(alignment: .center, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(alignment: .trailing)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        //                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
                        
                        // let swift handle the pluralization using markdown syntax
                        Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    }
                }
                .navigationTitle("BetterRest")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Calculate", action: calculateBedtime)
                }
                .padding()
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
            }
        }
        
    }
    
    func calculateBedtime() {
        // create coreml config and get the model
        // the model will be generated based on the filename.mlmode
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
