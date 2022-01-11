//
//  LazyImageView.swift
//  Country
//
//  Created by Евгений Григоренко on 11.01.22.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
    
    func loadImag(fromURL imageURL: URL){
        DispatchQueue.global().async {
            [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL)
            {
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
