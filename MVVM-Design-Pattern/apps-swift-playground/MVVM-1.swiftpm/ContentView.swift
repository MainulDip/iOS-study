import SwiftUI

struct ContentView: View {
    @State var title: String
    var viewModel: PetViewModel
    init(name: String = "Stuart") {
        let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
        let image = "cooking-logo-2"
        let stuart = Pet(
                name: name,
                birthday: birthday,
                rarity: .veryRare,
                image: image
            )
        viewModel = PetViewModel(pet: stuart)
    }
    var body: some View {
        TextField
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
