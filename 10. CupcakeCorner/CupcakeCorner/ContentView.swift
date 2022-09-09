//
//  ContentView.swift
//

import SwiftUI

// Example of how to let Swift know what data we want to write,
// knows how to convert some encoded data into object's properties
// and knows how to convert our object's properties into encoded data
class User: ObservableObject, Codable {
    
    // property wrapper wrap the value inside another type that adds some additional functionality
    // @Published is a generic struct that store any kind of value
    @Published private var name = "Paul Hudson"
    
    // 1. initializer is handed an instance of a new type called Decoder
    // 2. required means that any subclass needs to add their own values
    
    required init(from decoder: Decoder) throws {
        
        // 3. ask our Decoder instance for a container matching all the coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 4. read values directly form that container by referencing cases
        name = try container.decode(String.self, forKey: .name)
    }
    
    // Tell Swift how to encode this type
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

// Telling Swift which properties shoud be loaded and saved
enum CodingKeys: CodingKey {
    case name
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
