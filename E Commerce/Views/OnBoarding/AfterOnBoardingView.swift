import SwiftUI

struct AfterOnBoardingView: View {
    @AppStorage("onBoarding") var onBoarding = false
    @State private var showLoginView = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var imageRotation: Double = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Spacer()
//                Text("Richtide")
//                    .font(Font.custom("Space Grotesk", size: 24))
//                    .kerning(0.25)
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding()
                Spacer()
                Text("E-Richtide\nAll your clothing\nneeds")
                    .font(Font.custom("Space Grotesk", size: 34))
                    .kerning(0.25)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showLoginView = true
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color(red: 0.4, green: 0.03, blue: 0.37))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .sheet(isPresented: $showLoginView) {
                    LoginView()
                    

                }
                Spacer()

            }
            .padding()
            .frame(width: 400, height: 900)
            .background(Color(red: 0.4, green: 0.03, blue: 0.37))                 .cornerRadius(10)
        }
    }
}

struct AfterOnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        AfterOnBoardingView()
    }
}