//
//  UIViewRepresentableSample.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 16.09.2022.
//

import SwiftUI
import CoreLocation

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//   let manager = CLLocationManager()
//
//   @Published var latitude: Double?
//
//   override init() {
//
//       super.init()
//       requestLocation()
//       manager.delegate = self
//       manager.requestLocation()
//       manager.startUpdatingLocation()
//   }
//
//   func requestLocation() {
//       manager.requestLocation()
//   }
//
//   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//       latitude = locations.first?.coordinate.latitude
//   }
//}

struct UIViewRepresentableSample: View {
//    @StateObject private var vm = LocationManager()
    
    @State var textController : String = ""
    var body: some View {
        VStack{
            Text(textController)
            HStack {
                Text("SWIFTUI:")
                TextField("Write something...", text: $textController).frame(height:55).background(.gray)
            }
//            BasicUiViewRepresentable()
            
            HStack {
                Text("UIKit:")
                UiTextFieldViewRepresentable(
                    text: $textController,
                    placeHolder:"blabla")
                .frame(height:55).background(.gray)
            }
        }
    }
}

struct UIViewRepresentableSample_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableSample()
    }
}
struct UiTextFieldViewRepresentable : UIViewRepresentable {
    @Binding var textControllerForUiKit : String
    var placeHolder : String
    let placeHolderColor : UIColor
    init(text:Binding<String>,
         placeHolder:String,
         placeHolderColor:UIColor = .red){
        self._textControllerForUiKit = text
        self.placeHolder = placeHolder
        self.placeHolderColor = placeHolderColor
    }
    
    func makeUIView(context: Context) ->  UITextField {
        let textField =  getTextField()
        textField.delegate = context.coordinator
        return textField
    }
//    from swiftui to UIKİT
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = textControllerForUiKit
    }
    
    func updatePlaceHolder (_ text : String ) -> UiTextFieldViewRepresentable{
        var viewRepresentable = self
        viewRepresentable.placeHolder = text
        return viewRepresentable
    }
    
    
    private func getTextField () -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeHolder = NSAttributedString(string: placeHolder,attributes: [.foregroundColor: placeHolderColor ])
        textField.attributedPlaceholder = placeHolder
        
        return textField
    }
    //    from UIKİT to swiftui
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $textControllerForUiKit)
    }
    
    class Coordinator : NSObject ,UITextFieldDelegate{
        @Binding var textControllerForUiKit : String
        init(text : Binding<String>) {
            self._textControllerForUiKit = text}
        func textFieldDidChangeSelection(_ textField: UITextField) {
            guard let text = textField.text else {return}
            
            textControllerForUiKit = text
        }
    }
    
}

struct BasicUiViewRepresentable : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
