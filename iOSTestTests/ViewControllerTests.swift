import XCTest
@testable import iOSTest

class ViewControllerTests: XCTestCase {
    func test_init_shouldInitializeViewCorrectly() {
        let expectedModel = makeModel()
        let (sut, viewModel) = makeSUT(with: expectedModel)

        XCTAssertEqual(sut.view.subviews.count, 3)
        XCTAssertTrue(viewModel.fetchDataCalled)
    }

    // MARK: - Helpers

    private func makeSUT(with: Model, name: String = "any") -> (sut: ViewController,
                                                                viewModel: ViewModelSpy) {
        let viewModel = ViewModelSpy(with: with, name: name)
        let sut = ViewController(viewModel: viewModel)

        return (sut, viewModel)
    }

    private func makeModel() -> Model {
        return Model(title: "any-title",
                     actionButtonTitle: "any-action-title")
    }

    private final class ViewModelSpy: ViewModelProtocol {
        private let model: Model
        private let name: String
        var fetchDataCalled = false
        var saveNameCalled = false
        var getUserNameCalled = false
        var savedName: String?

        init(with model: Model, name: String) {
            self.model = model
            self.name = name
        }

        func fetchData() -> Model {
            fetchDataCalled = true
            return model
        }

        func saveName(with name: String) {
            savedName = name
            saveNameCalled = true
        }

        func getUserName() -> String {
            getUserNameCalled = true
            return name
        }
    }
}
