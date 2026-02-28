import Foundation
import SwiftUI

struct Lead: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let location: String
    let timestamp: Date
    let content: String
    let reporter: String
    let status: LeadStatus
    let aiAnalysis: String?
    let imageName: String?
    
    enum LeadStatus: String, Codable {
        case pending = "待处理"
        case investigating = "调查中"
        case resolved = "已解决"
        case archived = "已归档"
        
        var color: Color {
            switch self {
            case .pending: return .orange
            case .investigating: return .blue
            case .resolved: return .green
            case .archived: return .gray
            }
        }
    }
    
    /// Centralized icon logic based on imageName
    var systemImageName: String {
        switch imageName {
        case "factory": return "building.2.fill"
        case "maritime": return "ferry.fill"
        case "truck": return "truck.box.fill"
        case "package": return "shippingbox.fill"
        case "seller": return "person.badge.shield.checkmark.fill"
        default: return "doc.text.fill"
        }
    }
}
