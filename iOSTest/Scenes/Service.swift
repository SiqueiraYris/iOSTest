protocol ServiceProtocol {
    func fetchData() -> Model
}

final class Service: ServiceProtocol {
    func fetchData() -> Model {
        Model(title: "What's your name?",
              actionButtonTitle: "Save")
    }
}
