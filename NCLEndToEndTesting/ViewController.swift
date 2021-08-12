//
//  ViewController.swift
//  NCLEndToEndTesting
//
//  Created by Sevy, Michael on 8/4/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ViewModel()
    var currentShip: Ship?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "NCL Three Ships"

        viewModel.fetch {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let detailVC = segue.destination as? ShipDetailViewController {
                if let ship = currentShip {
                    detailVC.ship = ship
                }
            }
        }
    }
     
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShipTableViewCell", for: indexPath) as? ShipTableViewCell,
              viewModel.dataSource.count > 0 else { return UITableViewCell() }
        let ship = viewModel.dataSource[indexPath.row]
        cell.configure(ship: ship)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             guard  viewModel.dataSource.count > 0 else { return }
        let ship = viewModel.dataSource[indexPath.row]
        self.currentShip = ship
        performSegue(withIdentifier: "ShowDetailSegue", sender: self)
    }
    
    
}
