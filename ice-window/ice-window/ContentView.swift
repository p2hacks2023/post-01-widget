//
//  ContentView.swift
//  ice-window
//
//  Created by 榜士靖文 on 2023/12/16.
//

import SwiftUI
import UIKit
import FirebaseFirestore

struct ContentView: View {
    
    @State var moji = "aaaa";
    
    var body: some View {
        VStack {
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                // getData.listenMultiple()
                Firestore.firestore().collection("windowList").document("myWindow").getDocument { (success, error) in
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        let URL = success!.data()
                        print("Sucess")
                        let data = success!.data();
                        moji = data?["URL"] as? String ?? ""
                    }
                }
            }
            
            Text(moji);
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
