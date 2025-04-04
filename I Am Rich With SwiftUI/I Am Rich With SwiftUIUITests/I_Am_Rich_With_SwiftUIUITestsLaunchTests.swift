//
//  I_Am_Rich_With_SwiftUIUITestsLaunchTests.swift
//  I Am Rich With SwiftUIUITests
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 04/12/24.
//

import XCTest

final class I_Am_Rich_With_SwiftUIUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
