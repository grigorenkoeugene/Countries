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
            var imageUrlCompare: URL?

            let request = URLRequest(url: url)
                 imageUrlCompare = url
                 self.image = nil
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                self.image = image
                return
            }
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
                    if imageUrlCompare == url {
                        self.image = image
                    }
                }
            }).resume()
        }
}


