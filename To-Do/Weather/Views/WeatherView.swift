//
//  WeatherView.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            VStack {
                Group {
                    switch viewModel.weatherState {
                    case .loading:
                        ProgressView()
                    case .loaded(let data):
                        Image(systemName: data.weatherConditionDisplayIcon.rawValue).font(.largeTitle)
                        Text(data.displayTempreture).font(.system(size: 60))
                    }
                }
                
                Text("Current Temperature").font(.caption)
            }
            
            HStack(spacing: 32) {
                VStack {
                    Image(systemName: "sunrise").font(.title)
                    Group {
                        switch viewModel.astronomyState {
                        case .loading:
                            ProgressView()
                        case .loaded(let data):
                            Text(data.displaySunrise).font(.headline)
                        }
                    }
                }
                
                VStack {
                    Image(systemName: "sunset").font(.title)
                    Group {
                        switch viewModel.astronomyState {
                        case .loading:
                            ProgressView()
                        case .loaded(let data):
                            Text(data.displaySunset).font(.headline)
                        }
                    }
                }
            }
        }
        .alert("Error", isPresented: $viewModel.hasApiError) {
            
        } message: {
            Text(viewModel.apiErrorMessage ?? "")
        }
    }
}

#Preview {
    WeatherView()
}
