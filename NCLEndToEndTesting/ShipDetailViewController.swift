//
//  ShipDetailViewController.swift
//  NCLEndToEndTesting
//
//  Created by Sevy, Michael on 8/4/21.
//

import UIKit

enum Section: Int, CaseIterable {
    case facts
    case whatsIncluded
}

class ShipDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var shipImageView: UIImageView!
    
    var ship: Ship?
    let factKeys = ["Passenger Capacity", "Gross Register Tonnage", "Overall Length", "Max Beam", "Draft", "Engines", "Cruise Speed", "Crew", "Inaugural Date", "Remodeled Date"].sorted { $0 < $1 }
    var factValues = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Sort Dict alpha by key, then take those values for facts data source
        var values = [String]()
        if let ship = ship {
            let arr = ship.shipFacts.sorted{ $0.key < $1.key }
            
            for (_, value) in arr {
                values.append(value ?? "")
            }
        }
        self.factValues = values
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = self.ship?.shipName ?? ""
        if let path = ship?.bgeImagePath {
            shipImageView.imageFromServerURL(urlString: "https://www.ncl.com/\(path)", PlaceHolderImage: UIImage(systemName: "photo")!)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        shipImageView.image = nil
    }
    
}

extension ShipDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section),
              let ship = ship else { return 1 }
        
        switch section {
        case .facts:
            return ship.shipFacts.count
        case .whatsIncluded:
            return ship.whatsIncluded.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section),
              let ship = ship else { return UITableViewCell() }
        
        let factsCell = tableView.dequeueReusableCell(withIdentifier: "FactsCell", for: indexPath)
        let includedCell = tableView.dequeueReusableCell(withIdentifier: "IncludedCell", for: indexPath)
        
        switch section {
        case .facts:
            factsCell.textLabel?.text = factKeys[indexPath.row]
            factsCell.detailTextLabel?.text = factValues[indexPath.row]
            return factsCell
        case .whatsIncluded:
            includedCell.textLabel?.text = ship.whatsIncluded[indexPath.row]
            return includedCell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return "" }
        switch section {
        case .facts:
            return "Ship Facts"
        case .whatsIncluded:
            return "What's Included"
        }
    }
    
}
