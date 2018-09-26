import XCTest

class appUITests: XCTestCase {

  func testExample() {
    let application: XCUIApplication = XCUIApplication()
    application.launch()
    EarlGrey.selectElement(with: grey_keyWindow())
      .perform(grey_tap())
  }
}
