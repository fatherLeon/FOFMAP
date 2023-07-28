//
//  RecordViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Combine
import Foundation

final class RecordViewModel: ObservableObject {
    
    private var recordUseCase: any DetailFetchable
    private var userInfoUseCase: any DetailFetchable
    private var cancellables = Set<AnyCancellable>()
    private let matchType: MatchCategory
    private var offset = 20
    private var limit = 5
    
    var user: User?
    var error: UserError? = nil
    
    @Published var matches: [MatchDesc] = []
    @Published var isErrorShownAlert = false
    @Published var isPossibleFetch = false
    @Published var nickname: String = ""
    
    @MainActor
    init(nickname: String, matchCategory: MatchCategory, recordUseCase: any DetailFetchable, userInfoUseCase: any DetailFetchable) {
        self.nickname = nickname
        self.matchType = matchCategory
        self.recordUseCase = recordUseCase
        self.userInfoUseCase = userInfoUseCase
        
        receiveUserRecord()
    }
    
    func isLastItem(_ match: MatchDesc) -> Bool {
        guard let lastMatch = matches.last else {
            return false
        }
        
        if lastMatch.matchID == match.matchID {
            return true
        }
        
        return false
    }
    
    @MainActor
    func getAdditionalRecordMatches() {
        guard matches.isEmpty == false else { return }
        
        offset += limit
        recordUseCase = UserMatchRecordUseCase(nickname: nickname, matchType: matchType, offset: offset, limit: limit)
        
        Task { [weak self] in
            do {
                guard let newMatches = try await self?.recordUseCase.execute() as? [MatchDesc],
                      newMatches.isEmpty == false else {
                    self?.isPossibleFetch = false
                    return
                }
                
                self?.matches += newMatches
                self?.isPossibleFetch = true
            } catch {
                self?.isPossibleFetch = false
                self?.error = UserError.noExistMatchRecordAnymore
                self?.isErrorShownAlert = true
            }
        }
    }
    
    @MainActor
    private func receiveUserRecord() {
        Task { [weak self] in
            do {
                guard let user = try await self?.userInfoUseCase.execute() as? User else {
                    self?.error = UserError.noExistUser
                    self?.isErrorShownAlert = true
                    self?.isPossibleFetch = false
                    
                    return
                }
                
                self?.user = user
            } catch {
                self?.error = UserError.noExistUser
                self?.isErrorShownAlert = true
                
                return
            }
            
            do {
                guard let matches = try await self?.recordUseCase.execute() as? [MatchDesc] else { return }
                
                self?.matches = matches
                self?.isPossibleFetch = true
            } catch {
                self?.error = UserError.noExistMatchRecord
                self?.isErrorShownAlert = true
                self?.isPossibleFetch = false
            }
        }
    }
}
