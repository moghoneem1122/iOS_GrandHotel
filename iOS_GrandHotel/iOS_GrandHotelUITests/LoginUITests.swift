import XCTest

final class LoginUITests: XCTestCase {
    
    func testDebug() {

        let app = XCUIApplication()
        app.launch()

        sleep(4)

        print(app.debugDescription)
    }
    func testLoginScreenExists() {
        
        
        
     

        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(
            app.textFields["EmailTextField"]
                .waitForExistence(timeout: 10)
        )

        XCTAssertTrue(app.secureTextFields["PasswordTextField"].exists)

        XCTAssertTrue(app.buttons["LoginButton"].exists)
    }
    
    
    
    
    func testUserCanTypeEmail() {

        let app = XCUIApplication()

        app.launch()

        let email = app.textFields["EmailTextField"]

        email.tap()

        email.typeText("moghoneem556@gmail.com")

        XCTAssertEqual(
            email.value as? String,
            "moghoneem556@gmail.com"
        )
    }
    
    
    
    
    func testUserCanTypePassword() {

        let app = XCUIApplication()

        app.launch()

        let password = app.secureTextFields["PasswordTextField"]

        password.tap()

        password.typeText("123456")
    }
    
    
    
    func testLoginButtonExists() {
        
        let app = XCUIApplication()
        
        app.launch()
        
        XCTAssertTrue(app.buttons["LoginButton"].exists)
    }
    
    
    
    func testTapLoginButton() {

        let app = XCUIApplication()

        app.launch()

        let email = app.textFields["EmailTextField"]
        email.tap()
        email.typeText("ssd@gmail.com")

        let password = app.secureTextFields["PasswordTextField"]
        password.tap()
        password.typeText("dodo1177")

        app.buttons["LoginButton"].tap()
    }
    
    func testSuccessfulLoginNavigatesToWeather() {

        let app = XCUIApplication()
        app.launch()

        app.textFields["EmailTextField"].tap()
        app.textFields["EmailTextField"].typeText("ssd.com")

        app.secureTextFields["PasswordTextField"].tap()
        app.secureTextFields["PasswordTextField"].typeText("dodo1177")

        app.buttons["LoginButton"].tap()

        XCTAssertTrue(
            app.staticTexts["WeatherScreen"].waitForExistence(timeout: 5)
        )
    }
}
