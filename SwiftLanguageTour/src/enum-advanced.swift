// basic enum

enum Direction {
    case East
    case West
    case North
    case South
}

func getDirection(to direction: Direction) -> Void {
    switch direction {
        case .East:
            print("Go to East")
        case .West:
            print("Go to West")
        case .North:
            print("Go to North")
        case .South:
            print("Go to South")
    }
}

getDirection(to: .South)


// Enum With Raw Value
enum MapDirection: String {
    case East = "Head over to the East"
    case West = "Head over to the West"
}

func getMapDirection(to direction: MapDirection) -> Void {
    switch direction {
        case .East:
            print("\(direction.rawValue)")
        case .West:
            print("\(direction.rawValue)")
    }
}

getMapDirection(to: .West)

// Constant
enum AppEnvs {
    static let api = "someapikeys"
}


// CaseIterable
enum WeightUnit: CaseIterable {
    case lb
    case kg
}

print("CaseIterable total available cases \(WeightUnit.allCases.count)")

// Associated Values
enum SponsorRequest {
    case Facebook(currentUser: Int)
    case Youtube(user: Int)
    case Instagram
}

func getSponsor(user: SponsorRequest){
    switch user {           
        case .Facebook(let c) where c > 1_000:
            print("Facebook Users \(c), hence allowed for sponsorship")
        case .Youtube(user: let u):
            print("Youtube Users \(u)")
        case .Instagram:
            print("No user number requirements")
        case .Facebook: // when the where returns false
            print("Will be called when no associated value is supplied")
    }
}


getSponsor(user: .Facebook(currentUser: 10_000))
getSponsor(user: .Facebook(currentUser: 100))