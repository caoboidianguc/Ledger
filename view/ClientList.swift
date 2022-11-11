//
//  ClientList.swift
//  Ledger
//
//  Created by Thong Vu on 10/12/22.
//

import SwiftUI

struct ClientList: View {
    @EnvironmentObject var worker: KhachData
    @State var newCus = Khach.ThemKhach()
    @State private var trangMoi = false
    @State private var warning = ""
    @State private var existed = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(worker.theoNgay()) { $khach in
                    if khach.honTuan {
                        NavigationLink(destination: ClientDetail(khach: $khach) ){
                            KhachRow(khach: khach)
                        }
                        .swipeActions {
                            Button(role: .destructive, action: {
                                worker.delete(khach)
                            }, label: {
                                Label("Xoa", systemImage: "trash")
                            })
                        }
                    }
                }
            }//list
            .navigationTitle("Clients")
            .listStyle(.automatic)
            .navigationBarItems(trailing: Button(action: {trangMoi = true },
                                                 label: {Image(systemName: "plus")}))
            .sheet(isPresented: $trangMoi) {
                NavigationView {
                    ClientEdit(client: $newCus)
                        .alert("Failed to add", isPresented: $existed, actions: {}, message: {Text(warning)})
                        .navigationBarItems(leading: Button("Cancel"){
                            trangMoi = false
                        }, trailing: Button("Add"){
                            let newClient = Khach(name: newCus.name, sdt: newCus.sdt, desc: newCus.desc ,dvDone: newCus.dvDone)
                            if worker.daDen(newClient){
                                existed = true
                                warning = "Your client was in the list"
                                //trangMoi = false
                            } else {
                                worker.khach.khach.insert(newClient, at: 0)
                                trangMoi = false}
                        })
                        .onAppear{
                            newCus.name.removeAll()
                            newCus.sdt.removeAll()
                            newCus.desc.removeAll()
                        }
                }
        }
        }
        
    }//body
}

struct ClientList_Previews: PreviewProvider {
    static var previews: some View {
        ClientList()
            .environmentObject(KhachData())
    }
}
//.alert("Your client in the List", isPresented: $existed, actions: {}, message: {Text(warning)})
