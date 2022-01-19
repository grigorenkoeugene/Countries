//
//  LazyImageView.swift
//  Country
//
//  Created by Евгений Григоренко on 11.01.22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL, cache: URLCache = URLCache.shared) {
            let request = URLRequest(url: url)
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                self.image = image
                return
            }
            //Thread.sleep(forTimeInterval: .random(in: 0.3...1.3))
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard
                    let data = data,
                    let response = response,
                    ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                    let image = UIImage(data: data)
                else { return }
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async {
                    self.image = image
                }
            }).resume()
        }
}


