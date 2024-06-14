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
    @State private var licenseNumber = ""
    
    @State private var bloodGroup = "O+"
    @State private var height = ""
    @State private var weight = ""
    
    @State private var accountType = "Patient"
    @State private var isPasswordValid = false
    @State private var signUpAttempted = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSuccessAlert = false
    
    let genders = ["Male", "Female", "Other"]
    let bloodGroups = ["A+", "B+", "A-", "B-", "AB+", "AB-", "O+", "O-"]
    let specializations = ["Cardiology", "Dermatology", "Endocrinology", "Gastroenterology", "Hematology", "Neurology", "Oncology", "Pediatrics", "Psychiatry", "Rheumatology"]
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Account Type")) {
                    Picker("", selection: $accountType) {
                        Text("Doctor").tag("Doctor")
                        Text("Patient").tag("Patient")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender).tag(gender)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    TextField("Address", text: $address)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password, onCommit: {
                        validatePassword()
                    })
                    SecureField("Confirm Password", text: $confirmPassword, onCommit: {
                        validatePassword()
                    })
                    
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                if accountType == "Patient" {
                    Section(header: Text("Patient Information")) {
                        Picker("Blood Group", selection: $bloodGroup) {
                            ForEach(bloodGroups, id: \.self) { bloodGroup in
                                Text(bloodGroup)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        TextField("Height", text: $height)
                        TextField("Weight", text: $weight)
                    }
                }
                
                if accountType == "Doctor" {
                    Section(header: Text("Doctor Information")) {
                        TextField("Fees", text: $fees)
                            .keyboardType(.decimalPad)
                        TextField("Experience", text: $experience)
                        TextField("LicenseNumber", text: $licenseNumber)
                        TextField("Qualification", text: $qualification)
                        
                        TextField("About", text: $about)
                        Picker("Specialization", selection: $specialization) {
                            ForEach(specializations, id: \.self) { specialization in
                                Text(specialization)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
            }
            
            Button(action: {
                signUpAttempted = true
                signUp()
            }) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("User signed up successfully!"),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            
            NavigationLink(destination: Text("Sign In")) {
                Text("Already have an account? Sign In")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .navigationBarTitle("Sign Up", displayMode: .inline)
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func signUp() {
        // Ensure all fields are valid
        print("printing licensenumber  \(licenseNumber)")
        guard validateAllFields() else {
            showError = true
            return
        }
        
        guard password == confirmPassword, password.count >= 6 else {
            // Handle error: passwords do not match or have insufficient length
            isPasswordValid = false
            errorMessage = "Passwords must match and have a minimum length of 6 characters."
            showError = true
            return
        }
        
        // API call
        let url = URL(string: "https://hms-backend-1-1aof.onrender.com/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var user = [
            "firstName": firstName,
            "lastName": lastName,
            "age": Int(age) ?? 0,
            "gender": gender,
            "email": email,
            "phoneNumber": phoneNumber,
            "password": password,
            "accountType": accountType.lowercased(),
            "address": address
        ] as [String: Any]
        
        if accountType == "Doctor" {
            user["licenseNumber"] = Int(licenseNumber)
            user["fees"] = fees
            user["experience"] = experience
            user["qualification"] = qualification
            user["about"] = about
            user["specialization"] = specialization
        }
        if accountType == "Patient" {
            user["bloodGroup"] = bloodGroup
            user["height"] = height
            user["weight"] = weight
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
                        if let dataString = String(data: data, encoding: .utf8) {
                            print("Raw JSON response: \(dataString)")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showError = true
                        self.errorMessage = "Sign up failed"
                        if let dataString = String(data: data, encoding: .utf8) {
                            print("Raw JSON response: \(dataString)")
                        }
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
        // Check if passwords match and have a minimum length of 6 characters
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
        
        if let age = Int(age), age > 99 || age < 0 {
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
    func signUp(email: String, phoneNumber: String, password: String, firstName: String, lastName: String, userType: String, age: Int, gender: String, address: String) {
        // Implementation for data model's sign-up method
    }
}
