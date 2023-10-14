//
//  SepetDetay.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 12.10.2023.
//

import Foundation

class SepetDetay : Codable {
    var yemek_id:Int?
    var yemek_ad:String?
    var yemek_resim:String?
    var yemek_fiyat:Int?
    var yemek_adet:Int?
    
    init(yemek_id: Int, yemek_ad: String, yemek_resim: String, yemek_fiyat: Int, yemek_adet: Int) {
        self.yemek_id = yemek_id
        self.yemek_ad = yemek_ad
        self.yemek_resim = yemek_resim
        self.yemek_fiyat = yemek_fiyat
        self.yemek_adet = yemek_adet
    }
}
