
import SwiftUI
struct LogInView: View {

    @StateObject private var viewModel = LogInViewModel()

    var body: some View {

        if viewModel.isLoggedIn {
            WeatherView()
        } else {

            VStack {

                TextField("Email", text: $viewModel.email)
                    .accessibilityIdentifier("EmailTextField")

                SecureField("Password", text: $viewModel.password)
                    .accessibilityIdentifier("PasswordTextField")

                Button("Login") {
                    Task {
                        await viewModel.login()
                    }
                }
                .accessibilityIdentifier("LoginButton")

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}
