import SwiftUI

struct EmergencyButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            action()
        }) {
            VStack(spacing: 8) {
                Image(systemName: "sos.circle.fill")
                    .font(.system(size: 40))
                Text("紧急呼救")
                    .font(.headline)
                Text("一键上报位置并请求增援")
                    .font(.caption)
                    .opacity(0.8)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.red, Color(red: 0.8, green: 0, blue: 0)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .padding(.horizontal)
    }
}

struct EmergencyButton_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyButton(action: {})
            .previewLayout(.sizeThatFits)
    }
}
