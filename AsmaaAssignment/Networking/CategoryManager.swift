//
//  CategoryManager.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 26/11/2021.
//

import Foundation
import Alamofire


class CatagoryManager{
    static func getCategory(completion: @escaping ((_ data: Categories)->Void)){
        let url = ConstantUrl.nutritionData
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                
            case .success(_):
                guard let data = response.data else{ return }
                do{
                    let category =  try JSONDecoder().decode(Categories.self, from: data)
                    completion(category)
                } catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
