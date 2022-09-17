//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Umut Mutlu on 14.09.2022.
//

import CoreLocation
import Foundation
private let defaultIcon = "❓"
private let iconMap = {
    "Güneşli" = "☀️"
}

final class WeatherViewModel: ObservableObject {
    @Published var weather = [WeatherModel]

    @Published var city: String = "İzmir" {
        didSet {}
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }

    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = "EEE"
        return formatter
    }

    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
}
