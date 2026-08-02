import Foundation
import Alamofire

@MainActor
final class WeatherViewModel: ObservableObject {

    @Published var weather: Weather?
    @Published var city = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiKey = "ae37dcea0f0d4c9ea3405819260108"
    
    func fetchWeather() {
        guard !city.isEmpty else {
            errorMessage = "City name is required"
            return
        }
        self.city = city
        isLoading = true
        errorMessage = nil
        
    let urlString = "https://api.weatherapi.com/v1/current.json"
        AF.request(urlString,method: .get,parameters:[ "key":apiKey,"q":city,"aqi":"no"])
            .validate()
            .responseDecodable(of: Weather.self) { [weak self] response in
                
                self?.isLoading = false
                
                switch response.result {
                case .success(let weather):
                    self?.weather = weather
                    
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                    
                    
                }
                
        }
                
            }
    
    

    
