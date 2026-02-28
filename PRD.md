# LeadSight PRD (Product Requirements Document)

## 1. Project Overview

LeadSight is a specialized mobile application designed for **Tobacco Monopoly Law Enforcement Officers**. It leverages modern iOS design and real-time data monitoring to assist in combating illegal tobacco activities.

## 2. Target Audience

- Tobacco Monopoly Bureau Enforcement Teams
- Market Inspection Officers
- Intelligence and Investigation Units

## 3. Core Features

- **Smart Enforcement Dashboard**: Real-time visualization of high-risk "Smart Warnings".
- **Enforcement Lifecycle Tracking**: Comprehensive leads covering 5 key stages:
  1. **Outbound Solicitation**: Door-to-door selling and mobile unauthorized sales.
  2. **Specialized Vehicle Transport**: Intercepting vehicles transporting counterfeit/illegal tobacco.
  3. **Logistics & Delivery**: Monitoring parcel centers and express delivery networks.
  4. **Maritime Smuggling**: Tracking port arrivals and ship-to-shore smuggling.
  5. **Production Dens**: Detecting clandestine factories via thermal or power anomalies.
- **Centralized Data Store**: Unified state management for consistent reporting and investigation tracking.
- **Emergency SOS**: One-tap emergency reporting with location sharing for field officer safety.

## 4. Technical Requirements

- **Platform**: iOS 17.0+
- **Framework**: SwiftUI (utilizing the `@Observable` macro)
- **Design System**: Apple Human Interface Guidelines (HIG) with Material effects and SF Symbols.
- **Accessibility**: Full Dynamic Type support and VoiceOver compatibility.

## 5. UI/UX Goals

- **Premium Interface**: High-depth visuals using `.regularMaterial` and continuous corner radii.
- **Clarity**: High-contrast typography and intuitive iconography for field use.
- **Interactivity**: Fluid transitions and haptic feedback via symbol effects (pulse/bounce).
