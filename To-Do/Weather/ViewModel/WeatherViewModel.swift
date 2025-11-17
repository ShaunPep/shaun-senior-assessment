//
//  WeatherViewModel.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import Foundation
import CoreLocation

enum LoadingState<T> {
    case loading
    case loaded(T)
}

@MainActor
class WeatherViewModel: ObservableObject, @preconcurrency LocationServiceDelegate {
    private let apiClient = ApiClient()
    private let dateFormatter = DateFormatter()
    private var locationService: LocationService!
    
    @Published var weatherState: LoadingState<(Weather)> = .loading
    @Published var astronomyState: LoadingState<(WeatherAstronomy)> = .loading
    @Published var apiErrorMessage: String? = nil
    @Published var hasApiError: Bool = false
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        locationService = LocationService(with: self)
        locationService.getCurrentLocation()
    }
    
    private func displayErrorMessage(message: String) {
        apiErrorMessage = message
        hasApiError = true
    }
    
    func locationDidChange(location: CLLocation) {
        Task {
            do {
                let coordinates = location.coordinate
                let dateParameter = dateFormatter.string(from: Date.now)
                
                async let getWeather: Weather = apiClient.getData(url: "/current.json", parameters: ["q": "\(coordinates.latitude),\(coordinates.longitude)"])
                async let getAstronomy: WeatherAstronomy = apiClient.getData(url: "/astronomy.json", parameters: ["q": "\(coordinates.latitude),\(coordinates.longitude)", "dt": dateParameter])
                
                let (weather, astronomy) = await (try getWeather, try getAstronomy)
                self.weatherState = .loaded(weather)
                self.astronomyState = .loaded(astronomy)
            } catch APIError.invalidUrl {
                displayErrorMessage(message: "There is a problem with the URL provided")
            } catch APIError.invalidResponse {
                displayErrorMessage(message: "Incorrect response from API call")
            } catch APIError.invalidData {
                displayErrorMessage(message: "Invalid data returned from API")
            } catch APIError.unAuthorized {
                displayErrorMessage(message: "You are unauthorized to make this request")
            }
        }
    }
}
