//
//  QuoteView.swift
//  JokeFinder
//
//  Created by Ahmet Kaan Caliskan on 2025-04-02.
//


import SwiftUI

struct QuoteView: View {
    @StateObject var viewModel = QuoteViewModel()
    @State var punchlineOpacity = 0.0
    @State var buttonOpacity = 0.0

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
                        punchlineOpacity = 0.0
                        buttonOpacity = 0.0
                    }
                    
                    Task {
                        await viewModel.fetchQuote()
                    }
                } label: {
                    Text("New Quote")
                }
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchQuote()
            }
        }
    }
}

#Preview {
    QuoteView()
}
