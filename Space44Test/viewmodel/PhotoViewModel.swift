//
//  PhotoViewModel.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 14/12/2021.
//
import Foundation
class PhotoViewModel{
    var service:ServiceProtocol!
 
    init(service:ServiceProtocol = Service()) {
        self.service = service
    }
    func getPhotos(_ completion: @escaping (PictureResponseDTO?,Bool) -> ()){
        service.getImages(completion)
    }
    deinit {
     //
    }
}
