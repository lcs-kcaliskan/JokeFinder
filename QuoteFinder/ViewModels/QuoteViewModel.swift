//
//  JokeViewModel.swift
//  JokeFinder
//
//  Created by Ahmet Kaan Caliskan on 2025-04-02.
//

import Foundation

@Observable
class QuoteViewModel {
    
    // MARK: Stored properties
    var currentQuote: Quote?

    // MARK: Initializer
    init(currentQuote: Quote? = nil) {
        self.currentQuote = currentQuote
        
        // Load a quote from the endpoint
        Task {
            await fetchQuote()
        }
    }
    
    // MARK: Function(s)
    func fetchQuote() async {
        let endpoint = "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en"
        
        guard let url = URL(string: endpoint) else {
            print("Invalid address for JSON endpoint.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            // Decode the data
            let decodedData = try decoder.decode(QuoteWrapper.self, from: data)
            
            // Ensure UI updates happen on the main thread
            await MainActor.run {
                self.currentQuote = decodedData.quote
            }
            
        } catch {
            print("Could not retrieve data from endpoint or decode JSON.")
            print(error)
        }
    }
}

// Wrapper for the API response
struct QuoteWrapper: Codable {
    let quote: Quote
    
    private enum CodingKeys: String, CodingKey {
        case quote = "quoteText"  // Adjust this based on the actual API response
    }
}
