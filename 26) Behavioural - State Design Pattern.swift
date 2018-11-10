import UIKit

protocol State {
    func isSold(playerAuction: PlayerAuction) -> Bool
    func whichTeam(playerAuction: PlayerAuction) -> String?
}

class PlayerAuction {
    private var state: State = IsUnsoldState()
    
    var isSold: Bool {
        get {
            return state.isSold(playerAuction: self)
        }
    }
    
    var teamName: String? {
        get {
            return state.whichTeam(playerAuction: self)
        }
    }
    
    func changeStateToSold(teamName: String) {
        state = IsSoldState(teamName: teamName)
        
    }
    
    func changeStateToUnSold() {
        state = IsUnsoldState()
    }
    
}



class IsUnsoldState: State {
    func isSold(playerAuction: PlayerAuction) -> Bool { return false }
    
    func whichTeam(playerAuction: PlayerAuction) -> String? { return nil }
}

class IsSoldState: State {
    let teamName: String
    
    init(teamName: String) {
        self.teamName = teamName
    }
    
    func isSold(playerAuction: PlayerAuction) -> Bool {
        return true
    }
    
    func whichTeam(playerAuction: PlayerAuction) -> String? {
        return teamName
    }
}

func main(){
    let playerAuction = PlayerAuction()
    print(playerAuction.isSold, playerAuction.teamName)
    playerAuction.changeStateToSold(teamName: "Chennai Super Kings")
    print(playerAuction.isSold, playerAuction.teamName!)
}

main()

