//
//  Base.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 28/11/2021.
//

import Foundation

struct Base : Codable {
    let q : String?
    let from : Int?
    let to : Int?
    let more : Bool?
    let count : Int?
    let hits : [Hits]?

    enum CodingKeys: String, CodingKey {

        case q = "q"
        case from = "from"
        case to = "to"
        case more = "more"
        case count = "count"
        case hits = "hits"
    }

}
