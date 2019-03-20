//
//  UIImage + Extensions.swift
//  
//
//  Created by Jacari Boboye on 3/19/19.
//

import Foundation
import UIKit


extension UIImageView{
    
    func getSize() -> String{
        
        let imagePNGDataCount = Float((self.image?.pngData()?.count)!)

        let dataInKBUnit = Float(imagePNGDataCount / 1024)
        
        let dataInMBUnit = Float(dataInKBUnit / 1024).rounded()
        
        if(dataInMBUnit < 0){return "\(dataInKBUnit) KB"}
                
        return "\(dataInMBUnit) MB"
    }
}
