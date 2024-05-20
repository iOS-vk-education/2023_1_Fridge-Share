//
//  fridge_share_vkTests.swift
//  fridge&share_vkTests
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import XCTest
@testable import fridge_share_vk

final class fridge_share_vkTests: XCTestCase {
    var product: ProductData!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        product = ProductData(id: "testId", name: "test картоха", dateExploration: Date.now, dateAdded: Date.now, userId: "Артур Сардарян", status: statusOfProduct.available.rawValue, image: "картиночка", category: CategoriesOfProducts.meatAndFish.rawValue)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        product = nil
        
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        product.status = statusOfProduct.given.rawValue
        
        XCTAssert(product.status == statusOfProduct.given.rawValue)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            product.status = statusOfProduct.given.rawValue
        }
    }

}
