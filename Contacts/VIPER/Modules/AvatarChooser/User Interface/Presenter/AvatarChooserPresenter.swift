//
//  AvatarChooserPresenter.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class AvatarChooserPresenter: NSObject, AvatarChooserPresenterInterface, AvatarChooserInteractorOutput {
    
    weak var view: AvatarChooserViewInterface?
    weak var wireframe: AvatarChooserWireframe?
    
    var interactor:AvatarChooserInteractorInput
    var data:[AvatarDisplayData]?
    
    var moduleDelegate: AvatarChooserModuleDelegate?
    
    init(interactor:AvatarChooserInteractorInput) {
        self.interactor = interactor
        super.init()
    }
    
    // MARK: AvatarChooserPresenterInterface
    
    func refreshData() {
        interactor.findAvailableAvatars()
    }
    
    func numberOfAvatars() -> Int {
        return data?.count ?? 0
    }
    
    func setupAvatarInfo(index:Int, setup:(name:String?, avatarURL:String?) -> ()) {
        setup(name: data?[index].avatarName, avatarURL: data?[index].avatarURL)
    }

    func chooseAvatar(index:Int) {
        wireframe!.dismissViewController()
        moduleDelegate?.didChooseAvatar(data?[index].avatarURL)
    }
    
    // MARK: AvatarChooserInteractorOutput
    
    func foundAvailableAvatars(avatars:[Avatar]) {
        data = avatars.map { (avatar) -> AvatarDisplayData in
            let displayData = AvatarDisplayData()
            
            displayData.avatarName = avatar.title
            displayData.avatarURL = avatar.url
            
            return displayData
        }
        view?.dataRefreshed()
    }
    
    func failedToLoadAvailableAvatars() {
        view?.avatarLoadFail()
    }
    
}
