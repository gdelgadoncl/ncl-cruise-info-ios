//
//  ViewModel.swift
//  NCLEndToEndTesting
//
//  Created by Sevy, Michael on 8/4/21.
//

import Foundation

enum ShipType: Int, CaseIterable {
    case sky
    case bliss
    case gem
    
    var url: String {
        switch self {
        case .sky:
            return "https://www.ncl.com/cms-service/cruise-ships/SKY"
        case .bliss:
            return "https://www.ncl.com/cms-service/cruise-ships/BLISS"
        case .gem:
            return "https://www.ncl.com/cms-service/cruise-ships/GEM"
        }
    }
}
final class ViewModel {
    var dataSource = [Ship]()
   
    func fetch(completion: @escaping (() -> Void?)) {
        guard let sky = URL(string: ShipType.sky.url),
           let gem = URL(string: ShipType.gem.url),
           let bliss = URL(string: ShipType.bliss.url) else { return }
        
        let urls = [sky, gem, bliss]
        let queueDownloadTask = DispatchQueue(__label: "downloadQueue", attr: nil)
        
        for url in urls {
            queueDownloadTask.async() {
                
                let session = URLSession.shared
                let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
                    
                    let decoder = JSONDecoder()
                    if let ship = try? decoder.decode(Ship.self, from: data!) {
                        self.dataSource.append(ship)
                        completion()
                    }
                })
                task.resume()
            }
        }
    }
    
}
