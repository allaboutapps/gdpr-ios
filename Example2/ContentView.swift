//
//  ContentView.swift
//  Example2
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI
import GDPR

struct ContentView: View {
    init() {
        
//        UITableView.appearance().separatorColor = .clear
    }
    let listItems = ["Hello", "world", "I", "am", "a", "banana"]
    let sections = ["section1", "section2"]
    static let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    var body: some View {
        NavigationView{
            List {
                ForEach(sections, id:\.self) { section in
                    Section(header: Text(section)) {
                        ForEach(self.listItems, id: \.self){ item in
                            NavigationLink(destination: PrivacyPolicyView()){
                                HStack {
                                    Text(item)
                                    Spacer()
                                    Text("V")
                                        .font(.caption)
                                        .fontWeight(.black)
                                        .padding(5)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())

                                }
                            }
                            
                            
                        }
                    }
                }
                
                .navigationBarTitle("Example App")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

