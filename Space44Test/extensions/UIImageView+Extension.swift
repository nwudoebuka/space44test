//
//  UIImageView+Extension.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(with urlString: String, placeholder: Bool = false){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        
        if placeholder{
            self.kf.setImage(with: resource, placeholder:  #imageLiteral(resourceName: "icons8-full_image"))
        }else{
            self.kf.setImage(with: resource)
            kf.indicatorType = .activity
        }
        
    }
}
