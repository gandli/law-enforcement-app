import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkModeOverride") private var darkModeOverride = false
    
    var body: some View {
        List {
            Section("通知") {
                Toggle(isOn: $notificationsEnabled) {
                    Label("接收推送通知", systemImage: "bell.badge.fill")
                }
                
                if notificationsEnabled {
                    Toggle(isOn: .constant(true)) {
                        Label("紧急预警通知", systemImage: "exclamationmark.triangle.fill")
                    }
                    .disabled(true)
                    
                    Toggle(isOn: .constant(true)) {
                        Label("新线索分配通知", systemImage: "tray.full.fill")
                    }
                    .disabled(true)
                }
            }
            
            Section("显示") {
                Toggle(isOn: $darkModeOverride) {
                    Label("始终使用深色模式", systemImage: "moon.fill")
                }
            }
            
            Section("关于") {
                HStack {
                    Label("版本", systemImage: "info.circle")
                    Spacer()
                    Text("0.0.1")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Label("构建号", systemImage: "hammer")
                    Spacer()
                    Text("2026.03.01")
                        .foregroundStyle(.secondary)
                }
                
                NavigationLink {
                    LicenseView()
                } label: {
                    Label("开源许可", systemImage: "doc.text")
                }
            }
            
            Section("数据") {
                Button(role: .destructive) {
                    // Placeholder
                } label: {
                    Label("清除缓存", systemImage: "trash")
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("设置")
    }
}

/// Simple license placeholder
private struct LicenseView: View {
    var body: some View {
        ScrollView {
            Text("LeadSight 基于 Swift 和 SwiftUI 构建。\n\n本应用遵循 Apache 2.0 开源协议。")
                .font(.body)
                .foregroundStyle(.secondary)
                .padding()
        }
        .navigationTitle("开源许可")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
