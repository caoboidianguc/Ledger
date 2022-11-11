//
//  LedgerApp.swift
//  Ledger
//
//  Created by Thong Vu on 5/11/22.
//

import SwiftUI

@main
struct LedgerApp: App {
    @StateObject private var ledger = KhachData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView (){
                    KhachData.save(khach: ledger.khach){ result in
                        if case .failure(let failure) = result {
                            fatalError(failure.localizedDescription)
                        }
                    }
                }.environmentObject(ledger)
            }
            .onAppear {
                KhachData.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                        
                    case .success(let khach):
                        ledger.khach = khach
                    }
                }
            }
        }
    }
}

