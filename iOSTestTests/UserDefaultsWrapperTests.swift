import XCTest
@testable import iOSTest

class UserDefaultsWrapperTests: XCTestCase {
    func test_getData_shouldGetDataCorrectly() {
        let expectedKey = UserDefaultsKeys.userName
        let expectedData = "any-data"
        let (sut, userDefaults) = makeSUT(with: expectedData)

        let data = sut.getData(from: expectedKey)

        XCTAssertEqual(userDefaults.receivedMessages, [.string(defaultName: expectedKey.rawValue)])
        XCTAssertEqual(data, expectedData)
    }

    func test_saveData_shouldSaveDataCorrectly() {
        let expectedKey = UserDefaultsKeys.userName
        let expectedValue = "any-value"
        let (sut, userDefaults) = makeSUT(with: expectedValue)

        sut.saveData(value: expectedValue, to: expectedKey)

        XCTAssertEqual(userDefaults.receivedMessages, [.set(defaultName: expectedKey.rawValue)])
        XCTAssertEqual(userDefaults.value as! String, expectedValue)
    }

    // MARK: - Helpers

    private func makeSUT(with data: String? = nil) -> (sut: UserDefaultsWrapper, userDefaults: UserDefaultsSpy) {
        let userDefaults = UserDefaultsSpy(stringValue: data)
        let sut = UserDefaultsWrapper(userDefaults: userDefaults)

        return (sut, userDefaults)
    }

    private final class UserDefaultsSpy: UserDefaultsProtocol {
        private let stringValue: String?
        enum Messages: Equatable {
            case string(defaultName: String)
            case set(defaultName: String)
        }
        var value: Any?
        var receivedMessages: [Messages] = []

        init(stringValue: String?) {
            self.stringValue = stringValue
        }

        func string(forKey defaultName: String) -> String? {
            receivedMessages.append(.string(defaultName: defaultName))
            return stringValue
        }

        func set(_ value: Any?, forKey defaultName: String) {
            self.value = value
            receivedMessages.append(.set(defaultName: defaultName))
        }
    }
}
