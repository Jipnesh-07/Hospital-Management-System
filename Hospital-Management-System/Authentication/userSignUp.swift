//
//  userSignUp.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

//import SwiftUI
//import UniformTypeIdentifiers
//
//struct UserSignUp: View {
//    @EnvironmentObject var dataModel: DataModel
//    @Environment(\.presentationMode) var presentationMode
//
//    @State private var email = ""
//    @State private var phoneNumber = ""
//    @State private var password = ""
//    @State private var confirmPassword = ""
//    @State private var firstName = ""
//    @State private var lastName = ""
//    @State private var age = ""
//    @State private var gender = "Male"
//    @State private var address = ""
//
//    @State private var fees = ""
//    @State private var experience = ""
//    @State private var qualification = ""
//    @State private var about = ""
//    @State private var specialization = ""
//
//    @State private var accountType = "Patient"
//    @State private var isPasswordValid = false
//    @State private var signUpAttempted = false
//    @State private var showError = false
//    @State private var errorMessage = ""
//    @State private var showSuccessAlert = false
//
//    let genders = ["Male", "Female", "Other"]
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("Sign Up")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 20)
//
//                Picker("User Type", selection: $accountType) {
//                    Text("Doctor").tag("Doctor")
//                    Text("Patient").tag("Patient")
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//
//                Group {
//                    HStack {
//                        TextField("First Name", text: $firstName)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                        TextField("Last Name", text: $lastName)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                    .padding(.horizontal)
//
//                    TextField("Age", text: $age)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal)
//                        .keyboardType(.numberPad)
//
//                    Picker("Gender", selection: $gender) {
//                        ForEach(genders, id: \.self) { gender in
//                            Text(gender).tag(gender)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//
//                    TextField("Address", text: $address)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal)
//
//                    TextField("Phone Number", text: $phoneNumber)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal)
//                        .keyboardType(.phonePad)
//
//                    TextField("Email", text: $email)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//
//                    SecureField("Password", text: $password, onCommit: {
//                        validatePassword()
//                    })
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//
//                    SecureField("Confirm Password", text: $confirmPassword, onCommit: {
//                        validatePassword()
//                    })
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//
//                    if !isPasswordValid && signUpAttempted {
//                        Text("Passwords must match and have a minimum length of 6 characters.")
//                            .foregroundColor(.red)
//                            .padding(.horizontal)
//                    }
//
//                    if showError {
//                        Text(errorMessage)
//                            .foregroundColor(.red)
//                            .padding(.horizontal)
//                    }
//                }
//
//                if accountType == "Doctor" {
//                    Group {
//                        TextField("Fees", text: $fees)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.horizontal)
//                            .keyboardType(.decimalPad)
//
//                        TextField("Experience", text: $experience)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.horizontal)
//
//                        TextField("Qualification", text: $qualification)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.horizontal)
//
//                        TextField("About", text: $about)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.horizontal)
//
//                        TextField("Specialization", text: $specialization)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.horizontal)
//                    }
//                }
//
//                Button(action: {
//                    signUpAttempted = true
//                    signUp()
//                }) {
//                    Text("Sign Up")
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                .padding(.top)
//                .alert(isPresented: $showSuccessAlert) {
//                    Alert(
//                        title: Text("Success"),
//                        message: Text("User signed up successfully!"),
//                        dismissButton: .default(Text("OK")) {
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                    )
//                }
//
//                Spacer()
//
//                HStack {
//                    Text("Already have an account?")
//                    Button(action: {
//                        // Dismiss the current view
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Text("Sign In")
//                            .fontWeight(.bold)
//                    }
//                }
//                .padding(.bottom)
//            }
//        }
//    }
//
//    private func signUp() {
//        // Ensure all fields are valid
//        guard validateAllFields() else {
//            showError = true
//            return
//        }
//
//        guard password == confirmPassword, password.count >= 6 else {
//            // Handle error: passwords do not match or have insufficient length
//            isPasswordValid = false
//            errorMessage = "Passwords must match and have a minimum length of 6 characters."
//            return
//        }
//
//        // API call
//        let url = URL(string: "https://hms-backend-1-1aof.onrender.com/auth/signup")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        var user = [
//            "firstName": firstName,
//            "lastName": lastName,
//            "age": Int(age) ?? 0,
//            "gender": gender,
//            "email": email,
//            "phoneNumber": phoneNumber,
//            "password": password,
//            "accountType": accountType.lowercased(),
//            "address": address
//        ] as [String : Any]
//
//        if accountType == "Doctor" {
//            user["fees"] = fees
//            user["experience"] = experience
//            user["qualification"] = qualification
//            user["about"] = about
//            user["specialization"] = specialization
//        }
//
//
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: user)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    self.showError = true
//                    self.errorMessage = error.localizedDescription
//                }
//                return
//            }
//
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    self.showError = true
//                    self.errorMessage = "No data received"
//                }
//                return
//            }
//
//            do {
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//                if let json = jsonResponse as? [String: Any], let success = json["success"] as? Bool, success {
//                    DispatchQueue.main.async {
//                        self.showSuccessAlert = true
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        self.showError = true
//                        self.errorMessage = "Sign up failed"
//                    }
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.showError = true
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }.resume()
//    }
//
//    private func validatePassword() {
//        // Check if passwords match and have a minimum length of 6 characters
//        isPasswordValid = password == confirmPassword && password.count >= 6
//    }
//
//    private func validateAllFields() -> Bool {
//        if email.isEmpty || phoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty || firstName.isEmpty || lastName.isEmpty || age.isEmpty || address.isEmpty {
//            errorMessage = "All fields must be filled out"
//            return false
//        }
//
//        if !email.contains("@") {
//            errorMessage = "Invalid email address"
//            return false
//        }
//
//        if phoneNumber.count < 10 {
//            errorMessage = "Invalid phone number"
//            return false
//        }
//
//        if let ageInt = Int(age), ageInt <= 0 {
//            errorMessage = "Invalid age"
//            return false
//        }
//
//        if password != confirmPassword || password.count < 6 {
//            errorMessage = "Passwords must match and have a minimum length of 6 characters"
//            return false
//        }
//
//        return true
//    }
//}
//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserSignUp()
//            .environmentObject(DataModel())
//    }
//}
//
//class DataModel: ObservableObject {
//    func signUp(email: String, phoneNumber: String, password: String, firstName: String, lastName: String, userType: String, age: Int, gender: String, address: String) {
//        // Implementation for data model's sign-up method
//    }
//}
//

import SwiftUI
import UniformTypeIdentifiers

struct UserSignUp: View {
    @EnvironmentObject var dataModel: DataModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var gender = "Male"
    @State private var address = ""
    
    @State private var fees = ""
    @State private var experience = ""
    @State private var qualification = ""
    @State private var about = ""
    @State private var specialization = ""
    
    @State private var accountType = "Patient"
    @State private var isPasswordValid = false
    @State private var signUpAttempted = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSuccessAlert = false
    
    let genders = ["Male", "Female", "Other"]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                Picker("User Type", selection: $accountType) {
                    Text("Doctor").tag("Doctor")
                    Text("Patient").tag("Patient")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                commonFields
                
                if accountType == "Doctor" {
                    doctorFields
                }
                
                Button(action: {
                    signUpAttempted = true
                    signUp()
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top)
                .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("User signed up successfully!"),
                        dismissButton: .default(Text("OK")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
                
                Spacer()
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Sign In")
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom)
            }
        }
    }
    
    private var commonFields: some View {
        Group {
            HStack {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            
            TextField("Age", text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Picker("Gender", selection: $gender) {
                ForEach(genders, id: \.self) { gender in
                    Text(gender).tag(gender)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            
            TextField("Address", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.phonePad)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password, onCommit: {
                validatePassword()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            SecureField("Confirm Password", text: $confirmPassword, onCommit: {
                validatePassword()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            if !isPasswordValid && signUpAttempted {
                Text("Passwords must match and have a minimum length of 6 characters.")
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
            
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
        }
    }
    
    private var doctorFields: some View {
        Group {
            TextField("Fees", text: $fees)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.decimalPad)
            
            TextField("Experience", text: $experience)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Qualification", text: $qualification)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("About", text: $about)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Specialization", text: $specialization)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
    
    private func signUp() {
        guard validateAllFields() else {
            showError = true
            return
        }
        
        guard password == confirmPassword, password.count >= 6 else {
            isPasswordValid = false
            errorMessage = "Passwords must match and have a minimum length of 6 characters."
            return
        }
        
        let url = URL(string: "https://hms-backend-1-1aof.onrender.com/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var user: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "age": Int(age) ?? 0,
            "gender": gender,
            "email": email,
            "phoneNumber": phoneNumber,
            "password": password,
            "accountType": accountType.lowercased(),
            "address": address
        ]
        
        if accountType == "Doctor" {
            user["fees"] = fees
            user["experience"] = experience
            user["qualification"] = qualification
            user["about"] = about
            user["specialization"] = specialization
        }
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = "No data received"
                }
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                if let json = jsonResponse as? [String: Any], let success = json["success"] as? Bool, success {
                    DispatchQueue.main.async {
                        self.showSuccessAlert = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showError = true
                        self.errorMessage = "Sign up failed"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }.resume()
    }
    
    private func validatePassword() {
        isPasswordValid = password == confirmPassword && password.count >= 6
    }
    
    private func validateAllFields() -> Bool {
        if email.isEmpty || phoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty || firstName.isEmpty || lastName.isEmpty || age.isEmpty || address.isEmpty {
            errorMessage = "All fields must be filled out"
            return false
        }
        
        if !email.contains("@") {
            errorMessage = "Invalid email address"
            return false
        }
        
        if phoneNumber.count < 10 {
            errorMessage = "Invalid phone number"
            return false
        }
        
        if let ageInt = Int(age), ageInt <= 0 {
            errorMessage = "Invalid age"
            return false
        }
        
        if password != confirmPassword || password.count < 6 {
            errorMessage = "Passwords must match and have a minimum length of 6 characters"
            return false
        }
        
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUp()
            .environmentObject(DataModel())
    }
}

class DataModel: ObservableObject {
    func signUp(email: String, phoneNumber: String, password: String, firstName: String, lastName: String, userType
                : String, age: Int, gender: String, address: String, fees: String?, experience: String?, qualification: String?, about: String?, specialization: String?) {
                        // Implementation for data model's sign-up method
                        // You can handle the sign-up process here, interacting with your backend or data storage system.
                        // For the sake of this example, let's assume you interact with a backend API.
                    }
                }
