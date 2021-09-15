//
//  DataSets.swift
//  QiitaAPIApp
//
//  Created by Yabuki Shodai on 2021/09/15.
//

import Foundation


struct QiitaStruct: Codable {
    let title:String
    let user:User
   
}

struct User: Codable {
    var name: String
}
