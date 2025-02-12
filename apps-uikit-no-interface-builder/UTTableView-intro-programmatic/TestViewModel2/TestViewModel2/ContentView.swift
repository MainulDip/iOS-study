//
//  ContentView.swift
//  TestViewModel2
//
//  Created by Mainul Dip on 2/9/25.
//

import SwiftUI
import UIKit
import Combine

struct ContentView: View {
    @State var title: String = ""
    @ObservedObject var viewModel: PetViewModel
    init(name: String = "Stuart") {
        let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
        let image = "check"
        let stuart = Pet(
                name: name,
                birthday: birthday,
                rarity: .veryRare,
                image: image
            )
        viewModel = PetViewModel(pet: stuart)
    }
    
    var body: some View {
        TextField("Title", text: $title)
        VStack {
            Image(viewModel.image)
                .resizable()
                .frame(width: 400.0, height: 400.0)
            Text("Bismillah, Hello, world!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
    }
}

#Preview {
    ContentView()
}

// MARK: - Model
public class Pet {
    public enum Rarity {
        case common
        case uncommon
        case rare
        case veryRare
    }
    
    public let name: String
    public let birthday: Date
    public let rarity: Rarity
    public let image: String
    
    public init(name: String, birthday: Date, rarity: Rarity, image: String) {
        self.name = name
        self.birthday = birthday
        self.rarity = rarity
        self.image = image
    }
}


public class PetViewModel: ObservableObject {
    // 1
    @Published private var pet: Pet
    private let calender: Calendar
    
    public init(pet: Pet) {
        self.pet = pet
        self.calender = Calendar(identifier: .gregorian)
    }
    
    // 2
    public var name: String {
        return pet.name
    }
    
     public var image: String {
        return pet.image
    }
    
    // 3
    public var ageText: String {
        let today = calender.startOfDay(for: Date())
        let birthday = calender.startOfDay(for: pet.birthday)
        let components = calender.dateComponents([.year], from: birthday, to: today)
        let age = components.year!
        return "\(age) years old"
    }
    
    // 4
    public var adoptionFeeText: String {
        switch pet.rarity {
        case .common:
            return "$50.00"
        case .uncommon:
            return "75.00"
        case .rare:
            return "150.00"
        case .veryRare:
            return "$500.00"
        }
    }
}
