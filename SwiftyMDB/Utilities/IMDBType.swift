
import Foundation

enum IMDBType: String {
    case all = "All"
    case movie = "Movie"
    case series = "Series"
    case episode = "Episode"
    
    static func getTypes() -> [String] {
        return [all.rawValue, movie.rawValue, series.rawValue, episode.rawValue]
    }
}
