//
//  Yemekler.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 12.10.2023.
//

import Foundation

class Yemekler : Codable {
    var yemek_id:String?
    var yemek_adi:String?
    var yemek_resim:String?
    var yemek_fiyat:String?
    
    init(yemek_id: String, yemek_adi: String, yemek_resim: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim = yemek_resim
        self.yemek_fiyat = yemek_fiyat
    }
}
