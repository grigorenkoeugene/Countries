//
//  ReadJSON.swift
//  Country
//
//  Created by Евгений Григоренко on 6.01.22.
//

import Foundation
import UIKit

protocol Read {
    func readJSON(completed: @escaping () -> ())
}
    
class ReadJSON: Read {
    
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
                DispatchQueue.main.async {
                    
                    completed()
                }
            } catch let error {
                print(error)
            }
        }).resume()
    }
    
    

//    func Umage(comp: @escaping () -> ()) -> UIImage {
//        for i in countryArray {
//            let flagImage = i.flags.png
//            let url = URL(string: flagImage)
//            let data = try? Data(contentsOf: url!)
//            imageCell = UIImage(data: data!)
//            DispatchQueue.main.async {
//                comp()
//            }
//        }
//        return imageCell!
//
//    }
}
