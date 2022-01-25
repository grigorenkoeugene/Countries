//
//  LazyImageView.swift
//  Country
//
//  Created by Евгений Григоренко on 11.01.22.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
     
     var imageUrlCompare: URL?
    
     func loadImage(fromURL imageURL: URL){
         imageUrlCompare = imageURL
         self.image = nil
         DispatchQueue.global().async {
             [weak self] in
            Thread.sleep(forTimeInterval: .random(in: 0.1...1.3))
             let request = URLRequest(url: imageURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
             URLSession.shared.dataTask(with: request) { data, response, error in
                 if let data = data, let image = UIImage(data: data){
                     DispatchQueue.main.async {
                        if self?.imageUrlCompare == imageURL {
                             self?.image = image
                         }
                     }
                 }
             }.resume()
         }
    }
}
