//
//  NetworkingUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import UIKit

final class MostUsedPlayerUseCase {
    private var players: [Int: Int] = [:]
    private let provider = APIProvider()
    
    func getMostUsedPlayer() async throws {
        let matches = try await getAllMatches(.matchAllRecord(matchType: 50, offset: 0, limit: 100))
        
        for id in matches {
            var players = try await getMatchDescPlayer(.matchDesc(matchId: id))
            
            players.forEach { player in
                if self.players[player.spID] == nil {
                    self.players[player.spID] = 1
                } else {
                    self.players[player.spID]? += 1
                }
            }
        }
        
        let playersID = players.sorted { $0.value > $1.value }
    }
    
    private func getAllMatches(_ contentType: ContentType) async throws -> MatchAllRecord {
        guard let url = contentType.url else {
            throw NetworkError.urlError
        }
        
        let matchesID = try await provider.receiveData(url: url, by: MatchAllRecord.self)
        
        return matchesID
    }
    
    private func getMatchDescPlayer(_ contentType: ContentType) async throws -> [Player] {
        guard let url = contentType.url else {
            throw NetworkError.urlError
        }
        
        var result: [Player] = []
        let matchDesc = try await provider.receiveData(url: url, by: MatchDesc.self)
        
        matchDesc.matchInfo.forEach { matchInfo in
            result += matchInfo.player
        }
        
        return result
    }
    
    private func getPlayerActionImage(by spid: Int) async throws -> UIImage {
        guard let url = ContentType.metaPlayerActionshotImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let playerActionImage = try await provider.receiveImage(by: url)
        
        return playerActionImage
    }
    
    private func getPlayerImage(by spid: Int) async throws -> UIImage {
        guard let url = ContentType.metaPlayerImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let playerImage = try await provider.receiveImage(by: url)
        
        return playerImage
    }
    
    private func getPlayerSeasonImage(by spid: Int) async throws -> UIImage {
        guard let url = ContentType.metaSeasonId.url else {
            throw NetworkError.urlError
        }
        
        let seasonId = spid.distance(to: 3)
        let seasonInfo = try await provider.receiveData(url: url, by: MetaSeasonIds.self)
        
        guard let seasonImgURL = seasonInfo.first(where: { return seasonId == $0.seasonId })?.seasonImgURL,
              let imgURL = URL(string: seasonImgURL) else { throw NetworkError.invalidData }
        
        let seasonImg = try await provider.receiveImage(by: imgURL)
        
        return seasonImg
    }
}
