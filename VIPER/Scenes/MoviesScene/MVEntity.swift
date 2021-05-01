//
//  MoviesEntity.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import Foundation

struct MoviesEntity {
    let entityItems: [Movie]
    
    enum MovieResultCodingKey: String, CodingKey {
        case entityItems = "Search"
    }
}

struct Movie {
    let movieTitle: String
    let movieYear: String
    let movieImdbID: String
    let movieType: String
    let moviePoster: String
    
    enum MoviesCodingKeys: String, CodingKey {
        case movieTitle = "Title"
        case movieYear = "Year"
        case movieImdbID = "imdbID"
        case movieType = "Type"
        case moviePoster = "Poster"
    }
}

extension MoviesEntity: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieResultCodingKey.self)
        entityItems = try container.decode([Movie].self, forKey: .entityItems)
    }
}

extension Movie: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MoviesCodingKeys.self)
        movieTitle = try container.decode(String.self, forKey: .movieTitle)
        movieYear = try container.decode(String.self, forKey: .movieYear)
        movieImdbID = try container.decode(String.self, forKey: .movieImdbID)
        moviePoster = try container.decode(String.self, forKey: .moviePoster)
        movieType = try container.decode(String.self, forKey: .movieType)
    }
}
