//
//  ENAUITestsHome.swift
//  ENAUITests
//
//  Created by Dunne, Liam on 19/05/2020.
//  Copyright © 2020 SAP SE. All rights reserved.
//

import XCTest

class ENAUITestsHome: XCTestCase {

    override func setUpWithError() throws {
		continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeFlow_0000() throws {
		let app = XCUIApplication()
		setupSnapshot(app)
		app.setDefaults()
		app.launchEnvironment["isOnboarded"] = "YES"
		app.setPreferredContentSizeCategory(accessibililty: .normal, size: .M)
		app.launch()

		NotificationCenter.default.post(name: Notification.Name.isOnboardedDidChange, object: nil)

		// only run if onboarding screen is present
		XCTAssertNotNil(app.staticTexts[Accessibility.StaticText.homeActivateTitle])

		// assert cells
		let collectionView = app.collectionViews.element(boundBy:0)
		
		collectionView.scrollToElement(element: app.staticTexts[Accessibility.Cell.infoCardShareTitle])
		XCTAssert(app.staticTexts[Accessibility.Cell.infoCardShareTitle].exists)
		
		collectionView.scrollToElement(element: app.staticTexts[Accessibility.Cell.infoCardAboutTitle])
		XCTAssert(app.staticTexts[Accessibility.Cell.infoCardAboutTitle].exists)
		
		collectionView.scrollToElement(element: app.staticTexts[Accessibility.Cell.appInformationCardTitle])
		XCTAssert(app.staticTexts[Accessibility.Cell.appInformationCardTitle].exists)
		
		collectionView.scrollToElement(element: app.staticTexts[Accessibility.Cell.settingsCardTitle])
		XCTAssert(app.staticTexts[Accessibility.Cell.settingsCardTitle].exists)
		
    }

}
