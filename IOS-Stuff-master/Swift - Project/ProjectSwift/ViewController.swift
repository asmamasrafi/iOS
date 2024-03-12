//  ViewController.swift
//  ProjectSwift
//
//  Created by user on 2/29/24.
//  Copyright © 2024 hassan. All rights reserved.
//

import UIKit

class Continent {
    let name: String
    let countries: [String]
    var isOpened: Bool = false
    
    init(name: String, countries: [String], isOpened: Bool = false) {
        self.name = name
        self.countries = countries
        self.isOpened = isOpened
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let imageCountry = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let capital = UILabel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var continents = [Continent]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        
        // Set up models
        continents = [
            Continent(name: "Africa", countries: ["maroc", "tunis", "algeria"]),
            Continent(name: "Asia", countries: ["chine", "jordan", "iran", "chine", "jordan", "iran", "chine", "jordan", "iran", "chine", "jordan", "iran"]),
            Continent(name: "Europ", countries: ["espan", "france", "portugal", "espan", "france", "portugal", "espan", "france", "portugal"]),
        ]
        
        // Add tableView to the view
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        // Add titles
        addTitles()
    }
    
    func addTitles() {
        // Add title label for "Countries"
        let countriesTitleLabel = UILabel(frame: CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 50))
        countriesTitleLabel.text = "Countries"
        countriesTitleLabel.textAlignment = .center
        countriesTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(countriesTitleLabel)
        
        // Add title label for "Contents"
        let contentsTitleLabel = UILabel(frame: CGRect(x: 20, y: 150, width: view.frame.width - 40, height: 50))
        contentsTitleLabel.text = "Contents"
        contentsTitleLabel.textAlignment = .center
        contentsTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(contentsTitleLabel)
    }
    
    // UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return continents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = continents[section]
        return section.isOpened ? section.countries.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            continents[indexPath.section].isOpened = !continents[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            let country = continents[indexPath.section].countries[indexPath.row - 1]
            let description = "Description du pays" // Ajoutez ici une description du pays
            
            let countryDetailsVC = CountryDetailsViewController()
            countryDetailsVC.countryName = country
            countryDetailsVC.countryDescription = description
            // Assurez-vous que `CountryDetailsViewController` contient une propriété pour le nom et la description du pays
            
            navigationController?.pushViewController(countryDetailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = continents[indexPath.section].name
            cell.textLabel?.textColor = .systemBlue
            cell.backgroundColor = .clear
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = continents[indexPath.section].countries[indexPath.row - 1]
            cell.textLabel?.textColor = .systemRed
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    // UITableViewDelegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            continents[indexPath.section].isOpened = !continents[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            let country = continents[indexPath.section].countries[indexPath.row - 1]
            print(country)
            // Add code to navigate to details view controller
        }
    }
}
