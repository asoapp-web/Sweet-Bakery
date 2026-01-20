import SwiftUI

struct ContentView: View {
    
    let musicManager = MusicManager.shared
    @StateObject private var sweetPhotoManager = SweetProfilePhotoManager.shared
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    Settings()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image("XcSyQI")
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                
                if let sweetPhoto = sweetPhotoManager.sweetProfilePhoto {
                    Image(uiImage: sweetPhoto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(hex: "#50071C"), lineWidth: 2))
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                } else {
                    Circle()
                        .fill(Color(hex: "#E8DCC4"))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 35))
                                .foregroundColor(Color(hex: "#4A0D00"))
                        )
                        .overlay(Circle().stroke(Color(hex: "#50071C"), lineWidth: 2))
                }
                
                Spacer()
                
                NavigationLink {
                    Refrigator()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image("pobxMa")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(height: 50)
            
            Spacer()
            
            VStack {
                HStack {
                    NavigationLink {
                        Levels()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image("NZfUGV")
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    NavigationLink {
                        QuizSelection()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image("ZsJgSX")
                            .resizable()
                            .scaledToFit()
                    }
                }
                HStack {
                    NavigationLink {
                        Recipes()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image("MyGFmo")
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    NavigationLink {
                        Stories()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image("Acnsey")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
        .padding()
        .background {
            Image("kIQdUC")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
