//
//  LoginView.swift
//  TabNews
//
//  Created by Horacio Mota on 26/11/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {

        VStack {
            Spacer(minLength: 40)
            Text("Bem-vindo de Volta!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.bottom, 20)

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .foregroundColor(.black)
                .padding(.horizontal, 20)

            SecureField("Senha", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.top, 10)

            Button(action: loginUser) {
                Text("Entrar")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)

            Button("Novo usuário? Registre-se aqui") {
                // Ação para registro
            }
            .foregroundColor(.blue)
            .padding(.top, 10)

            Spacer()
        }
        .padding()
        .navigationTitle("Login")
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }


    }

    func loginUser() {
         guard let url = URL(string: "https://www.tabnews.com.br/api/v1/sessions") else { return }

         let body: [String: String] = [
             "email": email,
             "password": password
         ]

         guard let requestData = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }

         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.httpBody = requestData

         URLSession.shared.dataTask(with: request) { data, response, error in
             if let error = error {
                 DispatchQueue.main.async {
                     self.alertMessage = "Erro de rede: \(error.localizedDescription)"
                     self.showingAlert = true
                 }
                 return
             }

             if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                 DispatchQueue.main.async {
                     self.alertMessage = "Erro de servidor: \(httpResponse.statusCode)"
                     self.showingAlert = true
                 }
                 return
             }

             // Aqui você pode tratar a resposta da API
             DispatchQueue.main.async {
                 self.alertMessage = "Login bem-sucedido!"
                 self.showingAlert = true
             }

         }.resume()
     }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


#Preview {
    LoginView()
}
