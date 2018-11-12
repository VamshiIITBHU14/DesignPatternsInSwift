
import UIKit
import Foundation

class TeamRegister : CustomStringConvertible{
    
    var teamMembers = [String]()
    var memberCount = 0
    
    func checkInGuest (_ name : String) -> Int{
        
        memberCount += 1
        teamMembers.append("\(memberCount) - \(name)")
        return memberCount - 1
        
    }
    
    func checkOutGuest (_ index : Int) {
        teamMembers.remove(at: index)
    }
    
    var description: String{
        return teamMembers.joined(separator: "\n")
    }
}

class TeamConveyance {
    
    func takePlayersToStadium(_ teamRegister : TeamRegister){
        print("Taking players \n \(teamRegister.description) \n to the Stadium")
    }
    
    func dropPlayersBackAtHotel(){
        print("Dropping all the players back at Hotel")
    }
    
}




func main(){
    let teamRegister = TeamRegister()
    let player1 = teamRegister.checkInGuest("PlayerOne")
    let player2 = teamRegister.checkInGuest("PlayerTwo")
    
    print(teamRegister)
    
    teamRegister.checkOutGuest(1)
    print("------------------------------------")
    print(teamRegister)
    
    let player3 = teamRegister.checkInGuest("PlayerThree")
    
    print("------------------------------------")
    print(teamRegister)
    
    print("------------------------------------")
    let teamBus = TeamConveyance()
    teamBus.takePlayersToStadium(teamRegister)
    
    print("-------Match Over ----------")
    teamBus.dropPlayersBackAtHotel()
}

main()
