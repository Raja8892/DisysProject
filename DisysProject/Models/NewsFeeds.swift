//
//  NewsFeeds.swift
//  DisysProject
//
//  Created by Moses on 12/08/19.
//  Copyright © 2019 Raja Inbam. All rights reserved.
//

import Foundation

struct NewsFeeds {
    
    var payload: [Payload] = []
    
    init() {
        
    }
    
     init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        if json["success"] as? Bool ?? false{
            self.payload = (json["payload"] as? [[String: Any]] ?? []).compactMap{Payload(json: $0)}
        }
    }
}

public struct Payload{

    var title: String
    var description: String
    var date: String
    var image: String
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        title = json["title"] as? String ?? ""
        description = json["description"] as? String ?? ""
        date = json["date"] as? String ?? ""
        image = json["image"] as? String ?? ""
    }
}
