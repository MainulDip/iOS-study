import SwiftUI

public class PetViewModel: ObservableObject {
    // 1
    private let pet: Pet
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
