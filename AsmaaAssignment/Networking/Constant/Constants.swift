//
//  Constants.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 27/11/2021.
//

import Foundation

class ConstantUrl{
    
    private static let baseUrl = "https://api.edamam.com/"
    
    static let nutritionAppID = "1982de26"
    static let nutritionAppKey = "b590614fea6066db81bc1580085f1419"
    
    static let nutritionData = baseUrl + "api/nutrition-data?ingr=food&app_id=\(nutritionAppID)&app_key=\(nutritionAppKey)"
    
    
    
    
    static let searchAppID = "f1e5e5d5"
    static let searchAppKey = "cd79779d9939871c2cc78083a6751560"
    
    static let searchData = baseUrl + "search?q=all&app_id=\(searchAppID)&app_key=\(searchAppKey)"
}
