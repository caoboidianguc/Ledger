//
//  Technician.swift
//  Ledger
//
//  Created by Thong Vu on 7/20/22.
//

import Foundation
import SwiftUI

struct Technician: Codable {
    let name: String
    var services: [Service]
    var khach: [Khach]
    var opi:  [Opi] = []
    var weekEarn: [WeekEarn] = []
    
    init(name: String, services:[Service] = dvTech, khach: [Khach] = khachmau, opi: [Opi] = opiMau){
        self.name = name
        self.services = services
        self.khach = khach
        
    }
}
let quang = Technician(name: "Quang")

extension Technician {
    static var dvTech: [Service] = [Service(dichVu: "Full set", gia: 60),
                                    Service(dichVu: "GelPed", gia: 60),
                                    Service(dichVu: "Combo Gel", gia: 105),
                                    Service(dichVu: "Fill in", gia: 50),
                                    Service(dichVu: "Pedicure", gia: 45),
                                    Service(dichVu: "Gel mani", gia: 45),
                                    Service(dichVu: "Gel Add", gia: 15),
                                    Service(dichVu: "Combo Reg", gia: 70),
                                    Service(dichVu: "Nature Retreat", gia: 55),
                                    Service(dichVu: "Brisa Detox", gia: 70),
                                    Service(dichVu: "Ultimate", gia: 90),
                                    Service(dichVu: "Dip", gia: 50),
                                    Service(dichVu: "Ombre", gia: 70),
                                    Service(dichVu: "french", gia: 5),
                                    Service(dichVu: "Nail-Shape", gia: 10)]
    
    func tongTuan() -> Int {
        var tong = 0
        for client in khach {
            if !client.tuan {
                tong += client.khachTra()
            }
        }
        return tong
    }
    
//    func tong2Tuan() -> Int {
//        var tong = 0
//        for client in khach {
//            if !client.tuan2 {
//                tong += client.khachTra()
//            }
//        }
//        return tong
//    }
//    func tong(tuan: SoTuan) -> Int {
//        switch tuan {
//        case .tuandau:
//            return tongTuan()
//        case .haiTuan:
//            return tong2Tuan()
//        }
//    }
    
}//end extension

struct Opi: Codable {
    var name: String
    //var sample: Image
}

let opiMau = [Opi(name: "Buble Bath"),
              Opi(name: "It's a boy")]


//enum SoTuan: String, CaseIterable, Identifiable {
//    case tuandau = "A Week"
//    case haiTuan = "Two week"
//    var id: String {self.rawValue}
//    var name: String {self.rawValue}
//}
