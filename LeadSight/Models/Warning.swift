import Foundation
import SwiftUI

struct Warning: Identifiable, Codable {
    let id: UUID
    let type: String
    let title: String
    let description: String
    let severity: Severity
    
    enum Severity: String, Codable {
        case critical = "紧急"
        case high = "高度疑似"
        case medium = "注意"
        case low = "常规"
        
        var color: Color {
            switch self {
            case .critical: return .red
            case .high: return .orange
            case .medium: return .yellow
            case .low: return .blue
            }
        }
    }
}


