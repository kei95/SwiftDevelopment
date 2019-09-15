//
//  Registration.swift
//  HotelCornerstone
//
//  Created by Yamashtia Keisuke on 2019-09-09.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAdress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdult: String
    var numberOfChildren: String
    
    var roomType: RoomType
    var wifi: Bool
}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One king", shortName: "1K", price: 209),
            RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)

        ]
    }
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}


