
import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RegistrationViewModel()

    var body: some View {
        VStack {

            Spacer()

            Image("threads-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()

            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .modifier(TextFieldModifier())

                SecureField("Enter your passowrd", text: $viewModel.password)
                    .modifier(TextFieldModifier())

                TextField("Enter your full name", text: $viewModel.fullName)
                    .modifier(TextFieldModifier())

                TextField("Enter your username", text: $viewModel.username)
                    .modifier(TextFieldModifier())
            }

            if viewModel.loading {
                ProgressView()
            } else {
                Button {
                    Task {
                        try? await viewModel.createUser()
                    }
                } label: {
                    Text("Sign Up")
                        .modifier(AuthenticationButtonViewModifier())
                }
            }

            Spacer()

            Divider()

            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")

                    Text("Sign In")
                }
                .foregroundStyle(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
