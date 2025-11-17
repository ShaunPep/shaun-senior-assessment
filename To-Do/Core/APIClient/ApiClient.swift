//
//  ApiClient.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case unAuthorized
}

class ApiClient {
#if DEBUG
    let baseUrl: String = "https://api.weatherapi.com/v1"
    #else
    let baseUrl: String = ""
#endif
    
    private func getApiKey() -> String? {
        if let apiKey = ProcessInfo.processInfo.environment["API_KEY"] {
            return apiKey
        }
        
        return nil
    }
    
    private func createQueryUrl(requestUrl: URL, parameters: [String: String]? = nil) throws -> URL {
        guard var components = URLComponents(url: requestUrl, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidUrl
        }
        components.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let apiKey = getApiKey() else {
            throw APIError.unAuthorized
        }
        components.queryItems?.append(URLQueryItem(name: "key", value: apiKey))
        
        guard let queryUrl = components.url else {
            throw APIError.invalidUrl
        }
        
        return queryUrl
    }
    
    func getData<T: Decodable>(url: String, parameters: [String: String]? = nil) async throws -> T {
        guard let requestUrl = URL(string: "\(baseUrl)\(url)") else {
            throw APIError.invalidUrl
        }
        
        let queryUrl = try createQueryUrl(requestUrl: requestUrl, parameters: parameters)
        let (data, response) = try await URLSession.shared.data(from: queryUrl)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print(response)
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let result = try decoder.decode(T.self, from: data)
            
            return result
        } catch {
            throw APIError.invalidData
        }
    }
}
