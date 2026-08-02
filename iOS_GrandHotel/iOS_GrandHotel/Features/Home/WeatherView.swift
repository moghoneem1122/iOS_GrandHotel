import SwiftUI

struct WeatherView: View {

    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {
                    Text("Weather")
                    .accessibilityIdentifier("WeatherScreen")

                TextField("Enter City", text: $viewModel.city)
                    .textFieldStyle(.roundedBorder)

                Button("Get Weather") {
                    viewModel.fetchWeather()
                }
                .buttonStyle(.borderedProminent)

                if viewModel.isLoading {
                    ProgressView()
                }

                if let weather = viewModel.weather {

                    VStack(spacing: 12) {

                        Text(weather.location.name)
                            .font(.largeTitle)

                        Text("\(weather.current.temp_c, specifier: "%.1f")°C")
                            .font(.system(size: 50, weight: .bold))

                        Text(weather.current.condition.text)
                            .font(.title3)
                    }
                    .padding()
                }

                if let error = viewModel.errorMessage {

                    Text(error)
                        .foregroundStyle(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Weather")
            .accessibilityIdentifier("WeatherScreen")
            
            
        }
    }
}

#Preview {
    WeatherView()
}
