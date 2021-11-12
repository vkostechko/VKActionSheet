//
//  UIImageView+Utils.swift
//  VKActionSheet
//
//  Created by Viachaslau Kastsechka on 11/12/21.
//

import UIKit

extension UIImageView {
    
    @discardableResult 
    func setupImage(from url: URL?) -> URLSessionDataTask? {
        guard let url = url else { return nil }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        })
        task.resume()
        return task
    }
    
}
