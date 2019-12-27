//
//  Category.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import Foundation

struct Category: Codable {
    var title: String
    var nodes: [Node]
}

struct Node: Codable {
    var video: Video
}

struct Video: Codable {
    var encodeUrl: String
}
