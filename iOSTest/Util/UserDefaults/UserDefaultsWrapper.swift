protocol UserDefaultsWrapperProtocol: AnyObject {
    func saveData(value: String, to key: UserDefaultsKeys)
    func getData(from key: UserDefaultsKeys) -> String
}

final class UserDefaultsWrapper: UserDefaultsWrapperProtocol {
    private let userDefaults: UserDefaultsProtocol

    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }

    func saveData(value: String, to key: UserDefaultsKeys) {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func getData(from key: UserDefaultsKeys) -> String {
        return userDefaults.string(forKey: key.rawValue) ?? ""
    }
}
