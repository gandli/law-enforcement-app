import Foundation

struct Lead: Identifiable, Codable {
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
    }
}


