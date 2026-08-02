import XCTest
@testable import iOS_GrandHotel
@MainActor
final class LoginViewModelTests: XCTestCase {
    func testInitialValues() {

        let vm = LogInViewModel()

        XCTAssertEqual(vm.email, "")
        XCTAssertEqual(vm.password, "")
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }
    
    
    func testEmailChanges() {

        let vm = LogInViewModel()

        vm.email = "mohamed@gmail.com"

        XCTAssertEqual(vm.email, "mohamed@gmail.com")
    }
    
    
    func testPasswordChanges() {

        let vm = LogInViewModel()

        vm.password = "123456"

        XCTAssertEqual(vm.password, "123456")
    }
    
    
    
}
