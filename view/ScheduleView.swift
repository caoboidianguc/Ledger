//
//  ScheduleView.swift
//  Ledger
//
//  Created by Thong Vu on 11/16/22.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var worker: KhachData
    @State private var addClient = false
    @State private var khachHen = Khach.ThemKhach()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(QuaTuan.allCases){ quatuan in
                    if !worker.tuan(quaTuan: quatuan).isEmpty {
                        Section(content: {
                            ForEach(worker.tuan(quaTuan: quatuan)) { $khach in
                                NavigationLink(destination: ClientDetail(khach: $khach) ){
                                    KhachRow(khach: khach)
                                }
                            }
                        }, header: {Text(quatuan.name)})
                    }
                    
                }
            }
            .navigationTitle("Schedule")
                .navigationBarItems(trailing:
                    Button("Add"){
                        addClient = true
                    }
                )
                .sheet(isPresented: $addClient){
                    NavigationView {
                        ChonNgay(client: $khachHen)
                            .navigationBarItems(leading: Button("Cancel") {
                                addClient = false
                            }, trailing: Button("Add"){
                                let newApp = Khach(name: khachHen.name, sdt: khachHen.sdt,dvDone: khachHen.dvDone, ngay: khachHen.ngay)
                                worker.khach.khach.append(newApp)
                                addClient = false
                            })
                    }
                }
        }//navi
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(KhachData())
    }
}
