import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        
        if isUnlocked {
            LottieView(lottieFile: "homeAnimation", loopMode: .loop)
                .frame(height: 300)
            Divider()
            Text("Welcome!").bold()
            
            
        } else {
            VStack {
                
                LottieView(lottieFile: "signInAnimation", loopMode: .loop)
                    .frame(height: 300)
                Text("Sign in with FaceID/TouchID")
                    .frame(width: 300, height: 15)
                    .padding()
                    .background(Color(hue: 0.523, saturation: 0.0, brightness: 0.177))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .onTapGesture {
                        authenticate()
                    }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your device"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    self.isUnlocked = true
                } else {
                    // there was a problem
                    print(error?.localizedDescription)
                }
            }
        } else {
            // no biometrics
            print(error?.localizedDescription)
        }
    }
}
