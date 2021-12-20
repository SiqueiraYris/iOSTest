import XCTest
@testable import iOSTest

class ViewModelTests: XCTestCase {
    func test_fetchData_shouldReceiveCorrectData() {
        let expectedModel = makeModel()
        let (sut, service, _) = makeSUT(with: expectedModel)

        let data = sut.fetchData()

        XCTAssertTrue(service.fetchDataCalled)
        XCTAssertEqual(data, expectedModel)
    }

    func test_saveName_shouldSaveNameCorrectly() {
        let name = "any-name"
        let (sut, _, userDefaults) = makeSUT(with: makeModel())

        sut.saveName(with: name)

        XCTAssertEqual(userDefaults.receivedMessages, [.saveData(value: name,
                                                                 key: .userName)])
    }

    func test_getUserName_shouldReceiveCorrectName() {
        let expectedModel = makeModel()
        let expectedName = "any-name"
        let (sut, _, userDefaults) = makeSUT(with: expectedModel, name: expectedName)

        let userName = sut.getUserName()

        XCTAssertEqual(userDefaults.receivedMessages, [.getData(key: .userName)])
        XCTAssertEqual(userName, expectedName)
    }

    // MARK: - Helpers
    
    private func makeSUT(with model: Model, name: String = "any") -> (sut: ViewModel,
                                                                           service: ServiceSpy,
                                                                           userDefaults: UserDefaultsWrapperSpy) {
        let service = ServiceSpy(with: model)
        let userDefaults = UserDefaultsWrapperSpy(name: name)
        let sut = ViewModel(with: service, userDefaults: userDefaults)

        return (sut, service, userDefaults)
    }

    private func makeModel() -> Model {
        return Model(title: "any-title",
                     actionButtonTitle: "any-action-title")
    }

    private final class ServiceSpy: ServiceProtocol {
        private let model: Model
        var fetchDataCalled = false

        init(with model: Model) {
            self.model = model
        }

        func fetchData() -> Model {
            fetchDataCalled = true
            return model
        }
    }

    private final class UserDefaultsWrapperSpy: UserDefaultsWrapperProtocol {
        private let name: String

        enum Messages: Equatable {
            case saveData(value: String, key: UserDefaultsKeys)
            case getData(key: UserDefaultsKeys)
        }

        var receivedMessages: [Messages] = []

        init(name: String) {
            self.name = name
        }

        func saveData(value: String, to key: UserDefaultsKeys) {
            receivedMessages.append(.saveData(value: value, key: key))
        }

        func getData(from key: UserDefaultsKeys) -> String {
            receivedMessages.append(.getData(key: key))
            return name
        }
    }
}
