//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Umut Mutlu on 14.09.2022.
//

import Foundation
import Alamofire

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let apiKey : String  = "LTAVyiv6GKBWNGfMtQpbCyEGpoQD1c36"
    private var completionHandler : ((WeatherModel)->Void )?
    
    
     func loadWeatherData(_ completionHandler: @escaping ((WeatherModel) -> Void )){
        self.completionHandler=completionHandler
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
    }
    
    
    private func getCurrentLocId(coordinates:CLLocationCoordinate2D) ->String  {
        guard let urlString = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=LTAVyiv6GKBWNGfMtQpbCyEGpoQD1c36&q=\(coordinates.latitude)%\(coordinates.longitude)&language=tr-tr&details=false&toplevel=false%20HTTP/1.1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)else {return }
    
    }
    
}
enum WeatherService: String {
    case apiKey : String  = "LTAVyiv6GKBWNGfMtQpbCyEGpoQD1c36"
    case BASE_URL : String = "https://rickandmortyapi.com/api"
    case PATH : String = "/character"

    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickyMortiyeService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void)
}


struct RickyMortyService: IRickyMortiyeService {

    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickyMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }

}






//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Umut Mutlu on 14.09.2022.
//

import Foundation
import Alamofire

enum WeatherServiceEndPoint: String {
    case API_KEY   = "apikey=LTAVyiv6GKBWNGfMtQpbCyEGpoQD1c36&q="
    case BASE_URL = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?"

    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(API_KEY.rawValue)"
    }
}

protocol IWeatherService {
    func findLocationKeyByGeoPosition(latitude:String, longtitude:String) -> String )
  
}


struct WeatherService: IWeatherService {

 

}
