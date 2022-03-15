
import XCTest

@testable import Calculator

class CalculatorItemQueueTests: XCTestCase {
    
    var calculator = CalculatorItemQueue<Int>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_enqueue_element() {
        calculator.enqueue(1)
        calculator.enqueue(2)
        calculator.enqueue(3)
        
        let result = calculator.queue
        
        XCTAssertEqual(result, [1,2,3])
    }
    
    func test_dequeue_element() {
        calculator.enqueue(1)
        calculator.enqueue(2)
        calculator.enqueue(3)
        
        let outElement = calculator.dequeue()
        let result = calculator.queue
        
        XCTAssertEqual(result, [2,3])
        XCTAssertEqual(outElement, 1)
    }
    
}
