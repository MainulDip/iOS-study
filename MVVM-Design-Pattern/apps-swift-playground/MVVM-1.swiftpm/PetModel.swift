import SwiftUI

import UIKit

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
