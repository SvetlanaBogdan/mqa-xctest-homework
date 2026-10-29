//
//  Created by Netology.
//

import XCTest

class NetologyUITests: XCTestCase {

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()

        let username = "username"

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()

        let predicate = NSPredicate(format: "label CONTAINS[c] %@", username)
        let text = app.staticTexts.containing(predicate)
        XCTAssertNotNil(text)

        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
    
    func testLoginButtonDisabled() throws {
        let app = XCUIApplication()
        app.launch()

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText("username")

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        loginTextField.tap()
        
        let deleteText = String(repeating: XCUIKeyboardKey.delete.rawValue, count: 8)
        loginTextField.typeText(deleteText)
        
        let loginButton = app.buttons["login"]
        XCTAssertFalse(loginButton.isEnabled)
    }
    
    func testLoginWithDifferentUsername() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstUsername = "username"

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(firstUsername)
        
        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()
        
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        backButton.tap()
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))

        let secondUsername = "newuser"

        loginTextField.tap()
        let deleteText = String(repeating: XCUIKeyboardKey.delete.rawValue, count: firstUsername.count)
        loginTextField.typeText(deleteText)
        loginTextField.typeText(secondUsername)
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()
        
        
        let profileUsername = app.staticTexts["user_login"]
        XCTAssertTrue(profileUsername.waitForExistence(timeout: 5))
        
        let screenshot = XCTAttachment(screenshot: app.screenshot())
        screenshot.name = "Profile after second login - newuser"
        screenshot.lifetime = .keepAlways
        add(screenshot)
        
    }
}

