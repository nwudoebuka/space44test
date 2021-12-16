//
//  MockService.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 16/12/2021.
//

import Foundation

class MockService:ServiceProtocol {
    var isGetPhotoCalled = false
    func getImages(_ completion: @escaping (PictureResponseDTO?, Bool) -> ()) {
        isGetPhotoCalled = true
        let raw = "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000"
        let full = "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000"
        let regular = "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?autohttps://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000"
        
        let small = "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?autohttps://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000"
       
         let thumb = "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000"
        let urlData = Urls(raw: raw, full: full, regular: regular, small: small, thumb: thumb)
        
        let id = "7dghd-ryuioe8-ehjkdshabnjks"
        let width = 30
        let height = 60
        let color = "#bababa"
        let blurHash = "#bababa"
        let pictureResponseDTODescription = "mock picture"
        let altDescription = "mock picture"
       
        let links = PictureResponseDTOLinks(linksSelf: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", html: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", download: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", downloadLocation: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000")
        
        let categories = [JSONAny]()
        let likes = 56
        let likedByUser = true
        let currentUserCollections = [JSONAny]()
        
        let userLink = UserLinks(linksSelf: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", html: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", photos: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", likes: "456", portfolio: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", following: "598", followers: "589")
        
        let profileImage = ProfileImage(small: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", medium: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", large: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000")
       
        let social = Social(instagramUsername: "DoeMoMen", portfolioURL: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", twitterUsername: "dummyTwitter", paypalEmail: nil)
        
        let user = User(id: "857rhdf-8yghd-dsgfgd7n", username: "johnDoe", name: "John", firstName: "Doe", lastName: "D", twitterUsername: "dummyTwitt", portfolioURL: "https://a.loveholidays.com/sanity/production/dba45f84-a320-4d38-a73f-0fb0631db57e.jpg?auto=webp&quality=45&dpr=2&optimize=high&fit=crop&width=2000", bio: "a mock user", location: "Sanfrancisco", links: userLink, profileImage: profileImage, instagramUsername: "DoeMoMen", totalCollections: 57, totalLikes: 57, totalPhotos: 89, acceptedTos: true, forHire: true, social: social)
        
        let mockResponse = PictureResponseDTOElement(id: id, width: width, height: height, color: color, blurHash: blurHash, pictureResponseDTODescription: "mock description", altDescription: "mock description", urls: urlData, links: links, categories: categories, likes: 89, likedByUser: true, currentUserCollections: currentUserCollections, user: user)
        let mockResponseList = [mockResponse]
        completion(mockResponseList,true)
        
    }
    
    
}
