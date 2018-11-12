
import UIKit
import Foundation

protocol Command{
    func execute()
}

class BatsmanOutCommand : Command{
    var screenDisplay : ScreenDisplay
    
    init(_ screenDisplay : ScreenDisplay){
        self.screenDisplay = screenDisplay
    }
    
    func execute() {
        screenDisplay.isBatsmanOut()
    }
}

class BatsmanNotOutCommand : Command{
    var screenDisplay : ScreenDisplay
    
    init(_ screenDisplay : ScreenDisplay){
        self.screenDisplay = screenDisplay
    }
    
    func execute() {
        screenDisplay.isBatsmanNotOut()
    }
}


class ScreenDisplay{
    private var showOutOnDisplay = false
    
    func isBatsmanOut(){
        showOutOnDisplay = true
        print("Batsman is OUT")
    }
    
    func isBatsmanNotOut(){
        showOutOnDisplay = false
        print("Batsman is NOTOUT")
    }
    
}

class DisplaySwitch {
    var command : Command
    
    init(_ command : Command) {
        self.command = command
    }
    
    func pressSwitch(){
        command.execute()
    }
}

func main(){
    let screenDisplay = ScreenDisplay()
    
    let outCommand = BatsmanOutCommand(screenDisplay)
    let notOutCommand = BatsmanNotOutCommand(screenDisplay)
    
    let displaySwitchForOut = DisplaySwitch(outCommand)
    displaySwitchForOut.pressSwitch()
    
    let displaySwitchForNotOut = DisplaySwitch(notOutCommand)
    displaySwitchForNotOut.pressSwitch()
    
}

main()

