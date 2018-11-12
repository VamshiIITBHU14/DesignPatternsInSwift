import UIKit

//Suppose you have a TestBatsman class with fieldWell() and makeRuns()methods. And also a T20Batsman class with batAggressively() method. Let’s assume that you are short on T20Batsman objects and you would like to use TestBatsman objects in their place. TestBatsmen have some similar functionality but implement a different interface (they can bat but cannot bat in the way needed for a T20 match), so we can’t use them directly. So we will use adapter pattern. Here our client would be T20Batsman and adaptee would be TestBatsman.

protocol TestBatsman {
    func makeRuns()
    func fieldWell()
}

class Batsman1 : TestBatsman{
    func makeRuns() {
        print("I can bat well but only at StrikeRate of 80")
    }
    
    func fieldWell() {
        print("I can field well")
    }
}

protocol T20Batsman{
    func batAggressively()
}

class Batsman2 : T20Batsman{
    func batAggressively() {
        print("I need to bat well at a StrikeRate of more than 130")
    }
}

class TestBatsmanAdapter : T20Batsman{
    let testBatsman : TestBatsman
    init (_ testBatsman : TestBatsman){
        self.testBatsman = testBatsman
    }
    
    func batAggressively() {
        testBatsman.makeRuns()
    }
}

func main(){
    let batsman1 = Batsman1()
    let batsman2 = Batsman2()
    
    // Wrap a TestBatsman in a TestBatsmanAdapter so that he plays like T20Batsman
    let testBatsmanAdapter = TestBatsmanAdapter(batsman1)
    
    print("Test Batsman")
    batsman1.fieldWell()
    batsman1.makeRuns()
    
    print("T20 Batsman")
    batsman2.batAggressively()
    
    print("TestBatsmanAdapter")
    testBatsmanAdapter.batAggressively()
    
    
}

main()

