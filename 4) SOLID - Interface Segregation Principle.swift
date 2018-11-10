
import UIKit
import Foundation

// Before ISP
protocol MatchSummaryDisplay{
    func showLiveScore()
    func showCommentary()
    func showLiveTwitterFeed()
    func showSmartStats()
}

enum NoScreenEstate : Error
{
    case doesNotShowLiveTwitterFeed
    case doesNotShowSmartStats
}

extension NoScreenEstate: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .doesNotShowLiveTwitterFeed:
            return NSLocalizedString("No Screen Estate to show Live Twitter Feed", comment: "Error")
        case .doesNotShowSmartStats:
            return NSLocalizedString("No Screen Estate to show Smart Stats", comment: "Error")
        }
    }
}


class MobileDisplay:MatchSummaryDisplay{
    func showLiveScore() {
        print("Showing Live Score On Mobile")
    }
    
    func showCommentary() {
        print("Showing Commentary On Mobile")
    }
    
    func showLiveTwitterFeed() {
        do{
            let error: Error = NoScreenEstate.doesNotShowLiveTwitterFeed
            print(error.localizedDescription)
            throw error
        } catch{
            
        }
    }
    
    func showSmartStats() {
        do{
            let error: Error = NoScreenEstate.doesNotShowSmartStats
            print(error.localizedDescription)
            throw error
        } catch{
            
        }
    }
}

class TabletDisplay:MatchSummaryDisplay{
    func showLiveScore() {
        print("Showing Live Score On Tablet")
    }
    
    func showCommentary() {
        print("Showing Commentary On Tablet")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Tablet")
    }
    
    func showSmartStats() {
        do{
            let error: Error = NoScreenEstate.doesNotShowSmartStats
            print(error.localizedDescription)
            throw error
        } catch{
            
        }
    }
}

class DesktopDisplay:MatchSummaryDisplay{
    func showLiveScore() {
        print("Showing Live Score On Desktop")
    }
    
    func showCommentary() {
        print("Showing Commentary On Desktop")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Desktop")
    }
    
    func showSmartStats() {
        print("Showing Smart Stats On Desktop")
    }
}

//Following ISP

protocol LiveScoreDisplay{
    func showLiveScore()
    func showCommentary()
}

protocol TwitterFeedDisplay{
    func showLiveTwitterFeed()
}

protocol SmartStatsDisplay{
    func showSmartStats()
}

class ISPMobileDisplay:LiveScoreDisplay{
    func showLiveScore() {
        print("Showing Live Score On Mobile")
    }
    
    func showCommentary() {
        print("Showing Commentary On Mobile")
    }
}

class ISPTabletDisplay:LiveScoreDisplay, TwitterFeedDisplay{
    
    func showLiveScore() {
        print("Showing Live Score On Tablet")
    }
    
    func showCommentary() {
        print("Showing Commentary On Tablet")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Tablet")
    }
    
}

class ISPDesktopDisplay:LiveScoreDisplay, TwitterFeedDisplay, SmartStatsDisplay{
    
    func showLiveScore() {
        print("Showing Live Score On Desktop")
    }
    
    func showCommentary() {
        print("Showing Commentary On Desktop")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Desktop")
    }
    
    func showSmartStats() {
        print("Showing Smart Stats On Desktop")
    }
}

