//
//  WeatherInformModel.swift
//  WeatherApp
//
//  Created by Umut Mutlu on 14.09.2022.
//

import Foundation

// MARK: - WeatherModel

struct WeatherModel: Codable {
    let headline: Headline
    let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecast

struct DailyForecast: Codable {
    let date: Date
    let epochDate: Int
    let sun: Sun
    let moon: Moon
    let temperature, realFeelTemperature, realFeelTemperatureShade: RealFeelTemperature
    let hoursOfSun: Double
    let degreeDaySummary: DegreeDaySummary
    let airAndPollen: [AirAndPollen]
    let day: Day
    let night: Night
    let link: String

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case sun = "Sun"
        case moon = "Moon"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case realFeelTemperatureShade = "RealFeelTemperatureShade"
        case hoursOfSun = "HoursOfSun"
        case degreeDaySummary = "DegreeDaySummary"
        case airAndPollen = "AirAndPollen"
        case day = "Day"
        case night = "Night"
        case link = "Link"
    }
}

// MARK: - AirAndPollen

struct AirAndPollen: Codable {
    let name: String
    let value: Int
    let category: String
    let categoryValue: Int
    let type: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
        case category = "Category"
        case categoryValue = "CategoryValue"
        case type = "Type"
    }
}

// MARK: - Day

struct Day: Codable {
    let icon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let shortPhrase, longPhrase: String
    let precipitationProbability, thunderstormProbability, rainProbability, snowProbability: Int
    let iceProbability: Int
    let wind, windGust: Wind
    let totalLiquid, rain, snow, ice: Evapotranspiration
    let hoursOfPrecipitation, hoursOfRain, hoursOfSnow, hoursOfIce: Int
    let cloudCover: Int
    let evapotranspiration, solarIrradiance: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case shortPhrase = "ShortPhrase"
        case longPhrase = "LongPhrase"
        case precipitationProbability = "PrecipitationProbability"
        case thunderstormProbability = "ThunderstormProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case iceProbability = "IceProbability"
        case wind = "Wind"
        case windGust = "WindGust"
        case totalLiquid = "TotalLiquid"
        case rain = "Rain"
        case snow = "Snow"
        case ice = "Ice"
        case hoursOfPrecipitation = "HoursOfPrecipitation"
        case hoursOfRain = "HoursOfRain"
        case hoursOfSnow = "HoursOfSnow"
        case hoursOfIce = "HoursOfIce"
        case cloudCover = "CloudCover"
        case evapotranspiration = "Evapotranspiration"
        case solarIrradiance = "SolarIrradiance"
    }
}

// MARK: - Evapotranspiration

struct Evapotranspiration: Codable {
    let value: Double
    let unit: Unit
    let unitType: Int
    let phrase: String?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
}

enum Unit: String, Codable {
    case f = "F"
    case miH = "mi/h"
    case unitIn = "in"
    case wM = "W/m²"
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Evapotranspiration
    let direction: Direction

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}

// MARK: - Direction

struct Direction: Codable {
    let degrees: Int
    let localized, english: String

    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Localized"
        case english = "English"
    }
}

// MARK: - DegreeDaySummary

struct DegreeDaySummary: Codable {
    let heating, cooling: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case heating = "Heating"
        case cooling = "Cooling"
    }
}

// MARK: - Moon

struct Moon: Codable {
    let rise: Date
    let epochRise: Int
    let moonSet: Date
    let epochSet: Int
    let phase: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case moonSet = "Set"
        case epochSet = "EpochSet"
        case phase = "Phase"
        case age = "Age"
    }
}

// MARK: - Night

struct Night: Codable {
    let icon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let shortPhrase, longPhrase: String
    let wind, windGust: Wind
    let solarIrradiance: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case shortPhrase = "ShortPhrase"
        case longPhrase = "LongPhrase"
        case wind = "Wind"
        case windGust = "WindGust"
        case solarIrradiance = "SolarIrradiance"
    }
}

// MARK: - RealFeelTemperature

struct RealFeelTemperature: Codable {
    let minimum, maximum: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Sun

struct Sun: Codable {
    let rise: Date
    let epochRise: Int
    let sunSet: Date
    let epochSet: Int

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case sunSet = "Set"
        case epochSet = "EpochSet"
    }
}

// MARK: - Headline

struct Headline: Codable {
    let effectiveDate: Date
    let effectiveEpochDate, severity: Int
    let text, category: String
    let endDate: Date
    let endEpochDate: Int
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
