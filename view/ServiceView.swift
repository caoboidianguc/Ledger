//
//  ServiceView.swift
//  Ledger
//
//  Created by Thong Vu on 10/20/22.
//

import SwiftUI

struct ServiceView: View {
    @EnvironmentObject var worker: KhachData
    @State private var themdv = Service.themDv()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(worker.khach.services) { dv in
                    HStack {
                        Text(dv.dichVu)
                        Spacer()
                        Text("$\(dv.gia)")
                    }.padding(.bottom)
                        
                } //foreach
                
                .onDelete {xoa in
                    self.worker.khach.services.remove(atOffsets: xoa)
                }
                .navigationTitle("Services")
                
                HStack {
                    NewService(newSer: $themdv)
                    Button("Add", action: {
                        let newSer = Service(dichVu: themdv.dichVu, gia: themdv.gia)
                        worker.khach.services.append(newSer)
                    }).disabled(themdv.dichVu.isEmpty)
                }
            }
        }
        
        
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
        .environmentObject(KhachData())
    }
}


            
