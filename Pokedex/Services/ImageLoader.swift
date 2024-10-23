//
//  ImageLoader.swift
//  Pokedex
//
//  Created by Ben Blakesley on 18/10/2024.
//

import Foundation
import Combine
import UIKit

class ImageLoader
{
    private var cancellables = Set<AnyCancellable>()
    
    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void)
    {
        guard let url = URL(string: url) else {return}
        
        var uiImage: UIImage? = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink ( receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    print(completionResult)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { data in
                uiImage = UIImage(data: data)
                completion(uiImage)
            }
            )
            .store(in: &cancellables)
    }
}
