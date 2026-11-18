import UIKit

struct Genre {
    let id: Int
    let name: String
}

extension Genre {
    static let mock: [Genre] = [
        Genre(id: 27, name: "Terror"),
        Genre(id: 10749, name: "Romance"),
        Genre(id: 35, name: "Comédia"),
        Genre(id: 28, name: "Ação"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 53, name: "Suspense"),
        Genre(id: 878, name: "Ficção"),
        Genre(id: 16, name: "Animação"),
        Genre(id: 99, name: "Documentário")
    ]
}

struct StreamingPlatform {
    let id: Int
    let name: String
}

extension StreamingPlatform {
    static let mock: [StreamingPlatform] = [
        StreamingPlatform(id: 8, name: "Netflix"),
        StreamingPlatform(id: 119, name: "Prime Video"),
        StreamingPlatform(id: 337, name: "Disney+"),
        StreamingPlatform(id: 1899, name: "Max"),
        StreamingPlatform(id: 350, name: "Apple TV+"),
        StreamingPlatform(id: 307, name: "Globoplay")
    ]
}

final class FilterViewController: UIViewController {

    private let genreLabel = UILabel()
    private let platformLabel = UILabel()
    private let drawButton = UIButton(type: .system)

    private let genres = Genre.mock
    private let platforms = StreamingPlatform.mock

    private lazy var genreRows = makeChipRows(titles: genres.map { $0.name }, perRow: 3)
    private lazy var platformRows = makeChipRows(titles: platforms.map { $0.name }, perRow: 3)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        configGenreSection()
        configPlatformSection()
        configDrawButton()
    }

    // MARK: - Layout

    private func configGenreSection() {
        genreLabel.text = "Gênero"
        genreLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        view.addSubview(genreLabel)
        view.addSubview(genreRows)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreRows.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            genreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            genreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),

            genreRows.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 12),
            genreRows.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            genreRows.trailingAnchor.constraint(equalTo: genreLabel.trailingAnchor)
        ])
    }

    private func configPlatformSection() {
        platformLabel.text = "Plataformas"
        platformLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        view.addSubview(platformLabel)
        view.addSubview(platformRows)
        platformLabel.translatesAutoresizingMaskIntoConstraints = false
        platformRows.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            platformLabel.topAnchor.constraint(equalTo: genreRows.bottomAnchor, constant: 32),
            platformLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            platformLabel.trailingAnchor.constraint(equalTo: genreLabel.trailingAnchor),

            platformRows.topAnchor.constraint(equalTo: platformLabel.bottomAnchor, constant: 12),
            platformRows.leadingAnchor.constraint(equalTo: platformLabel.leadingAnchor),
            platformRows.trailingAnchor.constraint(equalTo: platformLabel.trailingAnchor)
        ])
    }
    
    private func configDrawButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Sortear"
        configuration.imagePadding = 8
        configuration.cornerStyle = .capsule

        drawButton.configuration = configuration

        view.addSubview(drawButton)
        drawButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            drawButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            drawButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            drawButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            drawButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    // MARK: - Componentes

    private func makeChipRows(titles: [String], perRow: Int) -> UIStackView {
        let rowsStack = UIStackView()
        rowsStack.axis = .vertical
        rowsStack.spacing = 8
        rowsStack.alignment = .leading

        for start in stride(from: 0, to: titles.count, by: perRow) {
            let end = min(start + perRow, titles.count)
            let chips = titles[start..<end].map { makeChip(title: $0) }

            let row = UIStackView(arrangedSubviews: chips)
            row.axis = .horizontal
            row.spacing = 8

            rowsStack.addArrangedSubview(row)
        }

        return rowsStack
    }

    private func makeChip(title: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.cornerStyle = .capsule
        configuration.titleLineBreakMode = .byTruncatingTail

        let button = UIButton(configuration: configuration)
        button.changesSelectionAsPrimaryAction = true

        button.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.baseBackgroundColor = .systemGray6
            config?.baseForegroundColor = .label
            config?.background.strokeColor = button.isSelected ? .systemBlue : .systemGray4
            config?.background.strokeWidth = button.isSelected ? 2.5 : 1
            button.configuration = config
        }

        return button
    }

}

#Preview {
    FilterViewController()
}
