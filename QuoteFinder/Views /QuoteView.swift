//
//  QuoteView.swift
//  JokeFinder
//
//  Created by Ahmet Kaan Caliskan on 2025-04-02.
//


import SwiftUI

struct QuoteView: View {
    
    // MARK: Stored properties
    @State var viewModel = QuoteViewModel()
    @State var punchlineOpacity = 0.0
    @State var buttonOpacity = 0.0
    @State var punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            if let currentQuote = viewModel.currentQuote {
                Group {
                    Text(currentQuote.quoteText)
                        .padding(.bottom, 100)
                    
                    Text(currentQuote.quoteAuthor)
                        .opacity(punchlineOpacity)
                }
                .font(.title)
                .multilineTextAlignment(.center)
                
                Button {
                    withAnimation {
                        viewModel.currentQuote = nil
                        punchlineOpacity = 0.0
                        buttonOpacity = 0.0
                    }
                    
                    Task {
                        await viewModel.fetchQuote()
                    }
                    
                    punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                } label: {
                    Text("New Quote")
                }
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
            }
        }
    }
}

#Preview {
    QuoteView()
}
