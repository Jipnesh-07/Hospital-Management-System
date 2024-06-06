//
//  Admin.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import Foundation

struct Admin: Decodable{
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    enum CodingKeys: CodingKey {
        case user
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
    }
    
    
}
