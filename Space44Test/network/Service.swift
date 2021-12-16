//
//  Service.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 14/12/2021.
//
/**
* I could  seperate the service class  further,
* have a base response, custom error e.t.c,
* but from the instruction I wish to make is simple and as easy to read as possible,
*/
import Foundation
protocol ServiceProtocol {
    func getImages(_ completion: @escaping (PictureResponseDTO?,Bool) -> ())
}
class Service:ServiceProtocol {
    func getImages(_ completion: @escaping (PictureResponseDTO?,Bool) -> ()) {
      
        let urlString = BASE_URL+API_KEY
        guard let url = URL(string: urlString) else{
            return
        }
        /**
        * I could  use Alamofire,
        * but chose the native library NSURLSESSION,
        * Alamofire uses NSURLSESSION under the hood too,
        */
        let request = URLRequest(url: url )
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let pictureResponseDTO = try JSONDecoder().decode(PictureResponseDTO.self, from: data!)
                        completion(pictureResponseDTO,true)
                        print(json)
                } catch {
                    completion(nil,false)
                    print("JSON error: \(error)")

                }
            }
        })
        task.resume()
    }
  
}
