import Foundation
import SwiftUI
import Observation

@Observable
class DataStore {
    var leads: [Lead] = []
    var warnings: [Warning] = []
    
    init() {
        // Mock data covering the 5 key stages of Tobacco Enforcement
        self.leads = [
            Lead(id: UUID(), title: "发现特大制假窝点", location: "郊区废弃厂房", timestamp: Date(), content: "红外扫描发现异常热源，疑似卷烟制造设备运行中。", reporter: "情报中心", status: .pending, aiAnalysis: "制假窝点：高频电力波动，有浓重烟叶气味。", imageName: "factory"),
            Lead(id: UUID(), title: "海运渠道走私香烟", location: "自贸区 4 号码头", timestamp: Date().addingTimeInterval(-1800), content: "集装箱报关项为‘日用品’，但重量感应异常，疑似夹带走私烟。", reporter: "海关联动", status: .investigating, aiAnalysis: "海运走私：X光扫描发现规则矩形堆叠。", imageName: "maritime"),
            Lead(id: UUID(), title: "专车运假拦截提示", location: "G15 高速收费站", timestamp: Date().addingTimeInterval(-3600), content: "目标车辆已进入拦截区，此前多次绕行避开检查站。", reporter: "路网系统", status: .investigating, aiAnalysis: "专车运假：轨迹高度重合，属于典型非法转运路径。", imageName: "truck"),
            Lead(id: UUID(), title: "物流寄递拆解结果", location: "某快递分拣中心", timestamp: Date().addingTimeInterval(-7200), content: "在申通某网点分拣过程中，嗅探犬发现疑似烟草包裹 50 件。", reporter: "分拣员", status: .resolved, aiAnalysis: "物流寄递：分散发货，化整为零，涉及多个虚假收货地址。", imageName: "package"),
            Lead(id: UUID(), title: "上门兜售抓获现场", location: "中山南路零售店", timestamp: Date().addingTimeInterval(-86400), content: "嫌疑人正在向无证户兜售‘散支’卷烟，已现场控制。", reporter: "便衣稽查", status: .resolved, aiAnalysis: "上门兜售：属于‘游击’式非法销售，货源不明。", imageName: "seller")
        ]
        
        self.warnings = [
            Warning(id: UUID(), type: "制假预警", title: "疑似制假窝点能耗激增", description: "该区域本月工业用电量超过过去 3 个月均值 500%。", severity: .critical),
            Warning(id: UUID(), type: "走私提示", title: "海上雷达轨迹异常", description: "一艘货船在非港区徘徊，并有小艇靠抵，疑似海上过驳。", severity: .high),
            Warning(id: UUID(), type: "寄递频率", title: "快递代收点异常收货", description: "单日出现 50 件以上发自边境敏感地区的卷烟规格包裹。", severity: .medium),
            Warning(id: UUID(), type: "串货提醒", title: "跨区调拨预警", description: "零售商扫码数据显示存在大量非本地喷码卷烟。", severity: .high)
        ]
    }
    
    func addLead(_ lead: Lead) {
        leads.insert(lead, at: 0)
    }
    
    func deleteLead(at offsets: IndexSet) {
        leads.remove(atOffsets: offsets)
    }
}
