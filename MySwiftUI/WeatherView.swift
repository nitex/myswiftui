//
//  WeatherView.swift
//  MySwiftUI
//
//  Created by exo on 31.07.2024.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherView: View {

    @Environment(\.colorScheme) var colorScheme

    @State private var weather: Weather?
    @State private var attLogo: URL?
    @State private var attributionURL: URL?
    @State private var logoImage: Image?

    let weatherService = WeatherService.shared

    var body: some View {
        VStack {
            if let weather {
                VStack {
                    Text("San Francisco")
                        .font(.largeTitle)
                    Text("\(weather.currentWeather.temperature.formatted()) | \(weather.currentWeather.condition.description)")
                }
            }//if let
            Spacer()
        
            //white letters on white box if device in dark mode
            AsyncImage(url: attLogo)
        
            Group{
                if let attributionURL {
                    Link("Weather Attribution", destination: attributionURL)
                }
            }//att group
        }//outer v
        .padding()
        .task {
            do {
                let location = CLLocation(latitude: 37.77, longitude: -122.41)
                self.weather = try await weatherService.weather(for: location)
            } catch {
                print(error)
            }//do catch
        }//task 1
        .task {
            do {
                let attribution = try await weatherService.attribution
                let attributionLink = attribution.legalPageURL
                self.attributionURL = attributionLink
                let attributionLogo = colorScheme == .light ? attribution.combinedMarkDarkURL : attribution.combinedMarkLightURL
                self.attLogo = attributionLogo
            } catch {
                print("failed to load attribution")
            }
        }//task for logo and link
    }//body
}//struct


#Preview {
    WeatherView()
}
