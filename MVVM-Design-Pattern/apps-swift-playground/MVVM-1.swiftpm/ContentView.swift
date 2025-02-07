import SwiftUI

struct ContentView: View {
    
    let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
    let image = "cooking-logo-2"
    lazy var stuart = Pet(
        name: "Stuart",
        birthday: birthday,
        rarity: .veryRare,
        image: image
    )
    
    lazy var viewModel = PetViewModel(pet: stuart)
    
    var body: some View {
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
