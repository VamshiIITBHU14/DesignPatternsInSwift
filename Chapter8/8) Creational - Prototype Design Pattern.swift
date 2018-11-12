import UIKit
import Foundation

protocol DeepCopy{
    func createDeepCopy () -> Self
}
class Profile : CustomStringConvertible, DeepCopy{
    var runsScored : Int
    var wicketsTaken : Int
    
    init(_ runsScored : Int, _ wicketsTaken : Int) {
        self.runsScored = runsScored
        self.wicketsTaken = wicketsTaken
    }
    
    var description: String{
        return "\(runsScored) Runs Scored & \(wicketsTaken) Wickets Taken"
    }
    
    func createDeepCopy() -> Self {
        return deepCopyImplementation()
    }
    
    private func deepCopyImplementation <T> () -> T{
        return Profile(runsScored, wicketsTaken) as! T
    }
}

class Cricketer : CustomStringConvertible ,DeepCopy{
    var name : String
    var profile : Profile
    
    init(_ name :String , _ profile : Profile) {
        self.name = name
        self.profile = profile
    }
    
    var description: String{
        return "\(name) : Profile : \(profile)"
    }
    
    func createDeepCopy() -> Self {
        return deepCopyImplementation()
    }
    
    private func deepCopyImplementation <T> () -> T{
        return Cricketer(name, profile) as! T
    }
    
}

func main(){
    let profile = Profile(1200, 123)
    let bhuvi = Cricketer("Bhuvi", profile)
    let ishant = bhuvi.createDeepCopy()
    ishant.name = "Ishant"
    ishant.profile = bhuvi.profile.createDeepCopy()
    ishant.profile.wicketsTaken = 140
    print(bhuvi.description)
    print(ishant.description)
}

main()

