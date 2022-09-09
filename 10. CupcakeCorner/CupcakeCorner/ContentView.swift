//
//  ContentView.swift
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    let iTunesApiUrl: String = "https://itunes.apple.com/search?term=taylor+swift&entity=song"
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    // tells Swift that this function might want to go to sleep in order to complete its work
    func loadData() async {
        // 1. creating the URL we want to read
        guard let url = URL(string: iTunesApiUrl) else {
            print("Invalid URL")
            return
        }
        
        // 2. fetching the data for that URL
        do {
            // takes a URL and returns the Data object at that URL
            // try -> might throw error
            // await -> wait for asynchronous functions complete
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 3. decoding the result of taht data into a Response struct
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
