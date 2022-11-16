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
    var weekEarn: [WeekEarn] = []
    
    init(name: String, services:[Service] = dvTech, khach: [Khach] = khachmau){
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
            if !client.hontuan {
                tong += client.khachTra()
            }
        }
        return tong
    }
    
    func tongNgay() -> Int {
        var tong = 0
        for lan in khach {
            if lan.today {
                tong += lan.khachTra()
            }
        }
        return tong
    }
    
    func tinhTheoNgay() -> Int {
        var tong = 0
        for ngay in weekEarn {
            tong += ngay.earn
        }
        return tong
    }
}//end extension


