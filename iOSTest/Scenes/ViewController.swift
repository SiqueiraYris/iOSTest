import UIKit

class ViewController: UIViewController {
    // TODO: - (1) Create views
    // TODO: - (2) Add views to superview
    // TODO: - (3) Get `Service` data to fill fields

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 44),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])

        view.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    private func createAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Name saved: " + , // TODO: - (6) Fill name
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc private func didTapButton() {
        // TODO: - (4) Save name to `UserDefaults`
        // TODO: - (5) Call alert
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
