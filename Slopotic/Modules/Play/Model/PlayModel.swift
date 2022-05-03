//
//  PlayModel.swift
//  Slopotic
//
//  Created by Weiyi Kong on 3/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

struct Playlist: Codable {
    static let baseURL = URL(string: "https://data.slopotic.tech/")!

    var title: String
    var image: String
    var music: [Music]
}

struct Music: Codable {
    var title: String
    var url: String
}
