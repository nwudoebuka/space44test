//
//  Space44TestTests.swift
//  Space44TestTests
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import XCTest
@testable import Space44Test

class Space44TestTests: XCTestCase {

    var viewModel: PhotoViewModel!
    var mockService:MockService!
    override func setUp() {
        mockService = MockService()
        viewModel = .init(service:mockService)
    }
    func testGetImages(){
        viewModel.getPhotos({
            val,stat in
        })
        XCTAssert(mockService.isGetPhotoCalled == true)
    }
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
}
