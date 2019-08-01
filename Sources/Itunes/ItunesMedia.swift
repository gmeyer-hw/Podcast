//
//  ItunesMedia.swift
//  Podcast
//
//  Created by Meyer, Gustavo on 7/13/19.
//  Copyright © 2019 Meyer Systems. All rights reserved.
//

import Foundation

struct ItunesMedia: Decodable {
    var artistName: String?
    var artworkUrl600: String?
    var feedUrl: String?
    var primaryGenreName: String?
    var trackCount: Int?
    var trackName: String?
}

extension ItunesMedia: Podcast {
    var audioCount: Int {
        return trackCount ?? 0
    }

    var artworkUrl: String? {
        return artworkUrl600
    }

    var name: String {
        return trackName ?? ""
    }

    var author: String {
        return artistName ?? ""
    }
}
