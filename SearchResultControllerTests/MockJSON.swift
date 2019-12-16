//
//  MockJSON.swift
//  SearchResultControllerTests
//
//  Created by Percy Ngan on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

let goodResultData = """
{
    "resultCount": 2,
    "results": [
        {
            "trackName": "GarageBand",
            "artistName": "Apple"
        },
        {
            "trackName": "Shortcut: GarageBand Edition",
            "artistName": "Mark Keroles"
        }
    ]
}
""".data(using: .utf8)!

let badResultData = """
{
    "resultCount": 2,
    "results": [
        {
            "trackName": "GarageBand",
            "artistName": "Apple"
        },
        {
            "trackName": "Shortcut: GarageBand Edition",
            "artistName": "Mark Keroles"
        }
    ]

""".data(using: .utf8)!

let noResultsData = """
{
    "resultCount": 0,
    "results": []
    }

""".data(using: .utf8)!
