
import SwiftUI

struct AdminProfile: View {
    @State private var isLoggedOut = false
    
    private func logout() {
        // Clear all data stored in UserDefaults
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "firstName")
        defaults.removeObject(forKey: "lastName")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "age")
        defaults.removeObject(forKey: "gender")
        defaults.removeObject(forKey: "bloodGroup")
        defaults.removeObject(forKey: "height")
        defaults.removeObject(forKey: "weight")
        defaults.removeObject(forKey: "authToken")
        defaults.removeObject(forKey: "userType")
        defaults.removeObject(forKey: "authToken")
        
        // Set isLoggedOut to true to trigger the navigation to sign-in screen
        isLoggedOut = true
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ProfileHeaderView()
                    
                    VStack(spacing: 1) {
                        NavigationLink(destination: PersonalInformationView()) {
                            HStack {
                                Image(systemName: "person.circle")
                                    .foregroundColor(.blue)
                                Text("Personal Information")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                        
                        NavigationLink(destination: AdminPatientsListView()) {
                            HStack {
                                Image(systemName: "person.3")
                                    .foregroundColor(.blue)
                                Text("Patients")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                        
                        NavigationLink(destination: AdminLabView()) {
                            HStack {
                                Image(systemName: "flask")
                                    .foregroundColor(.blue)
                                Text("Laboratory")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    
                    VStack(spacing: 1) {
                        NavigationLink(destination: helpView()) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                                Text("Help")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                        
                        NavigationLink(destination: privacyPolicy()) {
                            HStack {
                                Image(systemName: "lock.circle")
                                    .foregroundColor(.blue)
                                Text("Privacy Policy")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    
                    Button(action: {
                        logout()
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.white)
                    }
                }
                .padding(.top, 20)
                .fullScreenCover(isPresented: $isLoggedOut) {
                    userSignIn()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Account")
        }
    }
}

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.top, 40)
            
            Text("Admin")
                .font(.title)
                .padding(.top, 10)
            
            Text("admin@hospital.com")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct PersonalInformationView: View {
    var body: some View {
        Text("Personal Information View")
            .navigationBarTitle("Personal Information", displayMode: .inline)
    }
}


struct HelpView: View {
    var body: some View {
        Text("Help View")
            .navigationBarTitle("Help", displayMode: .inline)
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        Text("Privacy Policy View")
            .navigationBarTitle("Privacy Policy", displayMode: .inline)
    }
}



#Preview {
    AdminProfile()
}
