import Foundation
import SwiftUI
import Observation

@Observable
class DataStore {
    var leads: [Lead] = []
    var warnings: [Warning] = []
    
    init() {
        // Initial mock data
        self.leads = [
            Lead(id: UUID(), title: "违规占用消防通道", location: "朝阳区三里屯路 12 号院内", timestamp: Date(), content: "朝阳区三里屯路 12 号院内...", reporter: "Det. Sarah Smith", status: .pending, aiAnalysis: nil, imageName: "fire_lane"),
            Lead(id: UUID(), title: "商户占道经营语音记录", location: "东城区东直门内大街", timestamp: Date().addingTimeInterval(-3600), content: "已经口头警告，暂未进行罚款...", reporter: "Ofc. James Miller", status: .investigating, aiAnalysis: "语音识别完成，检测到敏感词：罚款、警告。", imageName: "street_vendor")
        ]
        
        self.warnings = [
            Warning(id: UUID(), type: "疑似套牌", title: "疑似套牌车辆预警", description: "车牌 京A·88888 轨迹异常，与登记车型不符", severity: .high),
            Warning(id: UUID(), type: "布控命中", title: "重点人员布控命中", description: "人脸识别特征值匹配度 94.2%", severity: .critical),
            Warning(id: UUID(), type: "人群聚集", title: "紧急：群体性聚集风险", description: "区域人流量超过阀值 200%，建议关注", severity: .critical)
        ]
    }
    
    func addLead(_ lead: Lead) {
        leads.insert(lead, at: 0)
    }
    
    func deleteLead(at offsets: IndexSet) {
        leads.remove(atOffsets: offsets)
    }
}
