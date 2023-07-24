//
//  resizeToSquare.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 22.07.2023.
//

import Foundation
import UIKit

extension UIImage {
    func resizeToSquare() -> UIImage {
        let newSize = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage ?? self
    }
}
