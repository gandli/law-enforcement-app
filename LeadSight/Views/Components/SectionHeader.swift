import SwiftUI

/// Reusable section header with optional action button
struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(.subheadline)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SectionHeader(title: "智能研判", actionTitle: "查看全部") {}
}
