//
//  WebService.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class WebService {
    static let shared = WebService()
    private let baseUrl = "http://localhost:3306"
    let decoder = JSONDecoder()
    let cache = NSCache<NSString, UIImage>()
    
    func fetchMenus() async throws -> [Menu] {
        guard let url = URL(string: baseUrl + "/menu") else { throw ErrorMessages.InvalidUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorMessages.InvalidResponse
        }
        
        do {
            let menus = try decoder.decode([Menu].self, from: data)
            return menus
        } catch {
            throw ErrorMessages.InvalidData
        }
    }
    
    func downloadImage(imageUrl: String) async -> UIImage? {
        let cacheKey = NSString(string: imageUrl)
        if let cachedImage = cache.object(forKey: cacheKey) { return cachedImage }
        
        guard let url = URL(string: imageUrl) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            
            return image
        }
        catch { return nil }
    }
}
