# LeadSight - Tobacco Law Enforcement Intelligence

LeadSight is a premium iOS application tailored for tobacco monopoly law enforcement. It provides real-time intelligence on illegal tobacco activities across five critical enforcement stages.

## Features

- 🛡️ **Premium iOS Interface**: Fully HIG-compliant with modern materials and animations.
- ⚡ **Real-time Intelligence**: Track leads from maritime smuggling to clandestine production.
- 🚨 **Smart Warnings**: Proactive alerts for high-risk license holders and abnormal transaction patterns.
- 🆘 **Emergency SOS**: Integrated emergency reporting for field officers.

## Project Structure

- `LeadSight/Models`: Data models (`Lead`, `Warning`) and the centralized `DataStore`.
- `LeadSight/Views`: SwiftUI components and view layers.
  - `Home`: Dashboard with smart judgment and latest inspections.
  - `Leads`: Detailed list and search interface for enforcement leads.
  - `Components`: Reusable UI elements (`WarningCard`, `EmergencyButton`, etc.).

## Requirements

- Xcode 15+
- iOS 17+ (SwiftUI with Observation framework)

## Setup

1. Open `LeadSight.xcodeproj` in Xcode.
2. Select an iOS 17+ simulator or device.
3. Build and run (Cmd+R).

## Documentation

- [PRD.md](PRD.md): Product Requirements Document.
- [CHANGELOG.md](CHANGELOG.md): Version history and updates.
