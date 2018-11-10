import Foundation

protocol Log
{
    func bowlerStatsFromCurrentMatch(_ stats: String)
    func batsmenStatsFromCurrentMatch(_ stats: String)
}

class StatsDisplayLog : Log
{
    func bowlerStatsFromCurrentMatch(_ stats: String) {
        print(stats)
    }
    
    func batsmenStatsFromCurrentMatch(_ stats: String) {
        print(stats)
    }
}

class NoDisplayStatsLog : Log
{
    func bowlerStatsFromCurrentMatch(_ stats: String) {}
    func batsmenStatsFromCurrentMatch(_ stats: String) {}
}


class UserInterface
{
    var log: Log
    var runsScored = 0
    var wicketsTaken = 0
    
    init(_ log: Log)
    {
        self.log = log
    }
    
    func wicketTaken (){
        wicketsTaken += 1
        log.bowlerStatsFromCurrentMatch("Total Wickets : \(wicketsTaken)")
    }
    
    func runsScored(numberOFRunsScored : Int){
        runsScored += numberOFRunsScored
        log.batsmenStatsFromCurrentMatch("Total Runs : \(runsScored)")
    }
    
}


func main()
{
    let ipadLog = StatsDisplayLog()
    let iPAdUserInterface = UserInterface(ipadLog)
    iPAdUserInterface.runsScored(numberOFRunsScored: 4)
    iPAdUserInterface.runsScored(numberOFRunsScored: 3)
    iPAdUserInterface.wicketTaken()
    
    let iPhoneLog = NoDisplayStatsLog()
    let iPhoneUserInterface = UserInterface(iPhoneLog)
    iPhoneUserInterface.runsScored(numberOFRunsScored: 6)
    iPhoneUserInterface.runsScored(numberOFRunsScored: 2)
    
}

main()

