//
//  TabBarItem.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 15.09.2022.
//

import Foundation
import SwiftUI

// struct TabBarItem: Hashable {
//    let iconName: String
//    let title : String
//    let color : Color
// }

enum TabBarItem: Hashable {
    case home, favorites, profile, light

    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person.crop.circle"
        case .light: return "bolt.square"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Person"
        case .light: return "Light"
        }
    }

    var color: Color {
        switch self {
        case .home: return Color.pink
        case .favorites: return Color.indigo
        case .profile: return Color.blue
        case .light: return Color.orange
        }
    }
}
