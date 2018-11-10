//Assume you are adding the stats (number of runs scored) of a cricketer year by year in your program and at some point of time you want to trace back to an year in the past and check his stats till that point of time

import UIKit

class Memento {
    let numberOfRunsScored : Int
    
    init(_ numberOfRunsScored : Int){
        self.numberOfRunsScored = numberOfRunsScored
    }
}

//StatsHolder is an imaginary hardware which displays the stats

class StatsHolder : CustomStringConvertible{
    
    private var numberOfRunsScored : Int
    
    init(_ numberOfRunsScored : Int) {
        self.numberOfRunsScored = numberOfRunsScored
    }
    
    func addStatsToHolder (_ runsToBeAdded : Int) -> Memento{
        numberOfRunsScored += runsToBeAdded
        return Memento(numberOfRunsScored)
    }
    
    func restoreToPastStat(_ memento : Memento){
        numberOfRunsScored = memento.numberOfRunsScored
    }
    
    var description: String{
        return "Total Runs scored = \(numberOfRunsScored)"
    }
}

func main(){
    let statsHolder = StatsHolder(1200) //1200 is the first stat (number of runs) we add to stats holder
    let stat1 = statsHolder.addStatsToHolder(1400)
    let stat2 = statsHolder.addStatsToHolder(700)
    
    print(statsHolder)
    
    //restoreToStat1
    statsHolder.restoreToPastStat(stat1)
    print(statsHolder)
    
    //restoreToStat2
    statsHolder.restoreToPastStat(stat2)
    print(statsHolder)
    
    //There is no memento/snapshot when the StatsHolder is initialised
}


main()

