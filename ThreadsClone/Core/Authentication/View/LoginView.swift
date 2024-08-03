import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Image("threads-app-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()

                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .modifier(TextFieldModifier())

                    SecureField("Enter your passowrd", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }

                NavigationLink {
                    Text("Forgot Passowrd")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(.black)
                }
                .padding(.bottom)

                if viewModel.loading {
                    ProgressView()
                } else {
                    Button {
                        Task {
                            try? await viewModel.login()
                        }
                    } label: {
                        Text("Login")
                            .modifier(AuthenticationButtonViewModifier())
                    }
                }

                Spacer()

                Divider()

                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")

                        Text("SignUp")
                    }
                    .foregroundStyle(.black)
                    .font(.footnote)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
