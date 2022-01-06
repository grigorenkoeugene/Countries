//
//  ReadJSON.swift
//  Country
//
//  Created by Евгений Григоренко on 6.01.22.
//

import Foundation

protocol read {
    func readJSON(completed: @escaping () -> ())
}
    
class ReadJSON: read {
    
    var countryArray = [Country]()
    
    public func readJSON(completed: @escaping () -> ()){
        let urlString = "https://restcountries.com/v3.1/all"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do{
                self.countryArray = try JSONDecoder().decode([Country].self, from: data)
                self.countryArray.sort(by: { $0.name.common < $1.name.common})
                DispatchQueue.main.sync {
                    completed()
                }
            } catch let error {
                print(error)
            }
        }).resume()
    }
}
