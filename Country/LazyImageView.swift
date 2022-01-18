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
    let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromURL imageURL: URL){
        imageUrlCompare = imageURL
        self.image = nil
        if let cacheImage = imageCache.object(forKey: imageURL as AnyObject) {
            self.image = cacheImage
            return
        }
        DispatchQueue.global().async {
            [weak self] in
            Thread.sleep(forTimeInterval: .random(in: 0.3...1.3))
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey:  imageURL as AnyObject)
                        
                        if self!.imageUrlCompare == imageURL {
                            self?.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}

