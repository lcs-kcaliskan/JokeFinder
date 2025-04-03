//
//  Joke.swift
//  JokeFinder
//
//  Created by Ahmet Kaan Caliskan on 2025-04-02.
//

import Foundation

struct Quote: Identifiable, Codable {
    var id: UUID { UUID() }  // Generates a new UUID each time
    let quoteText: String
    let quoteAuthor: String
}
