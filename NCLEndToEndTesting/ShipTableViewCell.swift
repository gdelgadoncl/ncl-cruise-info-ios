//
//  ShipTableViewCell.swift
//  NCLEndToEndTesting
//
//  Created by Sevy, Michael on 8/4/21.
//

import UIKit

class ShipTableViewCell: UITableViewCell {

    @IBOutlet weak var shipImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(ship: Ship) {
        if let path = ship.bgeImagePath {
            shipImageView.imageFromServerURL(urlString: "https://www.ncl.com/\(path)", PlaceHolderImage: UIImage(systemName: "photo")!)
        }
        titleView.text = ship.shipName
        descriptionLabel.text = ship.shipDescription
    }

}

extension UIImageView {

 public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil{
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}
