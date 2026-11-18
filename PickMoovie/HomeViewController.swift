//
//  HomeViewController.swift
//  PickMoovie
//
//  Created by Martenier Santos on 12/11/26.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let filterButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configTitle()
        configFilterButton()
        filterButton.addAction(UIAction {[weak self] _ in
            self?.showFilters()
        }, for: .primaryActionTriggered)
    }
    
    private func configTitle(){
        titleLabel.text = "O que vamos assistir hoje?"
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        titleLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 24
        ).isActive = true
        
        titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 24
        ).isActive = true
        
        titleLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func configFilterButton(){
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Selecionar filtros"
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 14,
            leading: 24,
            bottom: 14,
            trailing: 24
        )
        
        filterButton.configuration = configuration
        
        view.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 50
            ),
        ])
        
        filterButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 24
        ).isActive = true
        
        filterButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -24
        ).isActive = true
    }
    
    private func showFilters() {
        let filterVC = FilterViewController()
        
        if let sheet = filterVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(filterVC, animated: true)
    }
}

#Preview(){
    return HomeViewController()
}
