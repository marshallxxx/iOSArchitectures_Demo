//
//  AvatarListPresentor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

protocol AvatarListPresenterProtocol: class {
    init(view: AvatarListViewProtocol)
    
    func numberOfAvatars() -> Int
    func presentContact(index: Int)
    func getAvatarUrlAtIndex(index: Int) -> String?
}

class AvatarListPresenter: NSObject, AvatarListPresenterProtocol {
    unowned var view: AvatarListViewProtocol
    var avatars: [Avatar]?
    
    required init(view: AvatarListViewProtocol) {
        self.view = view
        super.init()

        ExternalConnector.sharedManager().networkManager.getAvatarList { [unowned self] (error, allAvatars) -> () in
            if let avatars = allAvatars {
                self.avatars = avatars
                
                self.view.dataReloaded()
            }
        }
        
    }
    
    // MARK: AvatarListPresenterProtocol
    func numberOfAvatars() -> Int {
        return avatars?.count ?? 0
    }
    
    func presentContact(index: Int) {
        let avatar = avatars![index]
        view.updateCell(avatar.title, avatarURL: avatar.url)
    }
    
    func getAvatarUrlAtIndex(index: Int) -> String? {
        return avatars?[index].url
    }
    
}
