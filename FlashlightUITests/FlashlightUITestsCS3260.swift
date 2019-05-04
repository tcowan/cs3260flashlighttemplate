//
//  FlashlightUITestsCS3260.swift
//  FlashlightUITests
//
//  Created by Ted Cowan on 9/3/18.
//  Copyright © 2018 TedCowan. All rights reserved.
//

//  Students: do not modify this file in any way.

import XCTest

class FlashlightUITestsCS3260: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func colorOfSnapshotAt(x: Float, y: Float) -> UIColor {
        let screen = XCUIScreen.main
        let screenshot = screen.screenshot()
        let image = screenshot.image
        let topLeft = CGPoint(x:0, y:0)
        return image.getPixelColor(pos: topLeft)
    }
    
    func testScreenIsBlackAtStartup() {
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        XCTAssertTrue(colorOfSnapshotAt(x: 0, y:0).isEqual(black))
    }
    
    func testScreenIsWhiteAfter1Tap() {
        app.tap()
        let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        XCTAssertTrue(colorOfSnapshotAt(x: 0, y:0).isEqual(white))
    }
 
    func testScreenIsLightGrayAfter2Taps() {
        app.tap()
        app.tap()
        let lightGray = UIColor(red: 2/3, green: 2/3, blue: 2/3, alpha: 1)
       XCTAssertTrue(colorOfSnapshotAt(x: 0, y:0).isEqual(lightGray))
    }

    func testScreenIsDarkGrayAfter3Taps() {
        app.tap()
        app.tap()
        app.tap()
        let darkGray = UIColor(red: 1/3, green: 1/3, blue: 1/3, alpha: 1)
        XCTAssertTrue(colorOfSnapshotAt(x: 0, y:0).isEqual(darkGray))
    }
    
    func testScreenIsRedAfter4Taps() {
        app.tap()
        app.tap()
        app.tap()
        app.tap()
        XCTAssertTrue(colorOfSnapshotAt(x: 0, y:0).isEqual(UIColor.red))
    }
    
    func testScreenIsBlackAfter5Taps() {
        app.tap()
        app.tap()
        app.tap()
        app.tap()
        app.tap()
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        XCTAssertTrue(colorOfSnapshotAt(x: 0, y:0).isEqual(black))
    }

}
extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

