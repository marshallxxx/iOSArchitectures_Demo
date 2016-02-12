//
//  AvatarListViewModel.swift
//  Contacts
//
//  Created by Ion Brumari on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol AvatarListViewModelProtocol: class {
    
    func getAvatarsCount() -> Int
    func selectWithIndex(index: Int)
    func avatartAtIndex(index: Int) -> AvatarCellViewModel
    func getSelectedAvatar() -> Avatar
    
    func getAvatars() -> SignalProducer<[Avatar], NoError>
}

class AvatarListViewModel: AvatarListViewModelProtocol {
    
    var selectedAvatar: Avatar?
    var avatars = [Avatar]()

    init() {

        getAvatars()
            .on(next: { self.avatars = $0 })
            .start()
    }
    
    
    func getAvatars() -> SignalProducer<[Avatar], NoError> {
        return SignalProducer { observer, disposable in
            
            ExternalConnector.sharedManager().networkManager.getAvatarList { (error, allAvatars) -> () in
                if let avatars = allAvatars {
                    self.avatars = avatars
                    observer.sendNext(avatars)
                    observer.sendCompleted()
                }
            }
        }
    }
    

    func getAvatarsCount() -> Int {
        return avatars.count
    }
    
    
    func avatartAtIndex(index: Int) -> AvatarCellViewModel {
        return AvatarCellViewModel(avatar: avatars[index])
    }

    
    func selectWithIndex(index: Int) {
        selectedAvatar = avatars[index]
    }
    
    
    func getSelectedAvatar() -> Avatar {
        return selectedAvatar!
    }
}
