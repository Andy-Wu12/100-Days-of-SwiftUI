//
//  ProspectsView.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/27/23.
//

import SwiftUI
import UserNotifications

import CodeScanner

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType {
        case recent, name
    }
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    
    @State private var sortingType: SortType = .recent
    @State private var showingSortMenu = false
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        let peopleToDisplay: [Prospect]
        switch filter {
        case .none:
            peopleToDisplay = prospects.people
        case .contacted:
            peopleToDisplay = prospects.people.filter { $0.isContacted }
        case .uncontacted:
            peopleToDisplay = prospects.people.filter { !$0.isContacted }
        }
        
        switch sortingType {
        case .recent:
            return peopleToDisplay
        case .name:
            return peopleToDisplay.sorted { $0.name < $1.name }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: prospect.isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.exclamationmark.fill")
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sort") {
                        showingSortMenu = true
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                /*
                 CodeScanner view takes three params
                 
                 1. Array of types of code we want to scan
                    We only need qr codes for this app so [.qr] is fine
                    but iOS supports lots of other types
                 2. A string to use as simulated data.
                    This is for the simulator since it doesn't support using camera to scan codes
                    CodeScannerView presents a replacement UI so we can test that things work
                 3. Completion function to use. Could be closure but we have handleScan below
                */
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "1211abBandy Wu\nawu@fakemail.com",
                    completion: handleScan)
                                
            }
            .confirmationDialog("Sort People", isPresented: $showingSortMenu) {
                Button("Recents (Default)") {
                    sortingType = .recent
                }
                Button("Name") {
                    sortingType = .name
                }
            } message: {
                Text("Choose Sort Type")
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Notification permission not given")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
