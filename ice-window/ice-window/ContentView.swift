import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @State var iceUrl: String = ""
    
    var body: some View {
        VStack {
            Button("Button") {
                Firestore.firestore().collection("windowList").document("myWindow").getDocument { (success, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        let data = success!.data()
                        print("Success")
                        iceUrl = data?["URL"] as? String ?? ""
                        
                        if let imageUrl = URL(string: iceUrl) {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 240, height: 126)
                        }
                    }
                }
            }
            .padding()
            
            Text(iceUrl)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
