//
//  CoreAssemblies.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit
import Typhoon

class CoreAssemblies: TyphoonAssembly {

    var contactListAssembly: ContactListAssembly?
    
    dynamic func appDelegate() -> AnyObject? {
        return TyphoonDefinition.withClass(AppDelegate.self) { [unowned self] (definition) -> Void in
            definition.injectProperty("window", with: self.mainWindow())
            definition.injectProperty("mainWireframe", with: self.contactListAssembly!.contactListWireframe())
        }
    }
    
    dynamic func mainWindow() -> AnyObject {
        return TyphoonDefinition.withClass((UIWindow.self), configuration: { [unowned self] (definition) -> Void in
            definition.useInitializer("initWithFrame:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(NSValue(CGRect: UIScreen.mainScreen().bounds))
            })
            definition.injectProperty("rootViewController", with: self.rootViewController())
        })
    }

    dynamic func rootViewController() -> AnyObject {
        return TyphoonDefinition.withClass(UINavigationController.self)
    }

}

class ContactListAssembly: TyphoonAssembly {

    var contactDetailsAssembly: ContactDetailsAssembly?
    
    dynamic func contactListWireframe() -> AnyObject {
        return TyphoonDefinition.withClass((ContactsListWireframe.self), configuration: { [unowned self] (definition) -> Void in
            definition.useInitializer("initWithPresenter:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(self.contactsListPresenter())
            })
            
            definition.injectProperty("contactDetailsWireframe", with: self.contactDetailsAssembly!.contactDetailsWireframe())
            
            })
        
    }
    
    private dynamic func contactsListPresenter() -> AnyObject {
        return TyphoonDefinition.withClass(ContactsListPresenter.self, configuration: { [unowned self] (definition) -> Void in
            
            //init(interactor:ContactListInteractorInput)
            definition.useInitializer("initWithInteractor:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(self.contactListInteractor())
            })
            
            definition.injectProperty("wireframe", with: self.contactListWireframe())
        }) 
    }
    
    private dynamic func contactListInteractor() -> AnyObject {
        return TyphoonDefinition.withClass(ContactsListInteractor.self, configuration: { [unowned self] (definition) -> Void in
            
            definition.injectProperty("output", with: self.contactsListPresenter())
            
        })
    }
    
}

class ContactDetailsAssembly: TyphoonAssembly {
    var avatarChooserAssembly: AvatarChooserAssembly?
    var contactListAssembly: ContactListAssembly?
    
    dynamic func contactDetailsWireframe() -> AnyObject {
        return TyphoonDefinition.withClass((ContactDetailsWireframe.self), configuration: { [unowned self] (definition) -> Void in
            definition.useInitializer("initWithPresenter:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(self.contactDetailsPresenter())
            })
            
            definition.injectProperty("avatarChooserWireframe", with: self.avatarChooserAssembly!.avatarChooserWireframe())
            
        })
    }
    
    private dynamic func contactDetailsPresenter() -> AnyObject {
        return TyphoonDefinition.withClass(ContactDetailsPresenter.self, configuration: { [unowned self] (definition) -> Void in
            definition.useInitializer("initWithInteractor:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(self.contactDetailsInteractor())
            })
            
            definition.injectProperty("wireframe", with: self.contactDetailsWireframe())
            definition.injectProperty("moduleDelegate", with: self.contactListAssembly!.contactsListPresenter())
        })
    }
    
    private dynamic func contactDetailsInteractor() -> AnyObject {
        return TyphoonDefinition.withClass(ContactDetailsInteractor.self, configuration: { [unowned self] (definition) -> Void in
            definition.injectProperty("output", with: self.contactDetailsPresenter())
        })
    }
    
}

class AvatarChooserAssembly: TyphoonAssembly {
    
    var contactDetailsAssembly: ContactDetailsAssembly?
    
    dynamic func avatarChooserWireframe() -> AnyObject {
        return TyphoonDefinition.withClass((AvatarChooserWireframe.self), configuration: { [unowned self] (definition) -> Void in
            definition.useInitializer("initWithPresenter:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(self.avatarChooserPresenter())
            })
            })
    }
    
    private dynamic func avatarChooserPresenter() -> AnyObject {
        return TyphoonDefinition.withClass(AvatarChooserPresenter.self, configuration: { [unowned self] (definition) -> Void in
            definition.useInitializer("initWithInteractor:", parameters: { (initializer) -> Void in
                initializer.injectParameterWith(self.avatarChooserInteractor())
            })
            
            definition.injectProperty("wireframe", with: self.avatarChooserWireframe())
            definition.injectProperty("moduleDelegate", with: self.contactDetailsAssembly!.contactDetailsPresenter())
            
        })
    }
    
    private dynamic func avatarChooserInteractor() -> AnyObject {
        return TyphoonDefinition.withClass((AvatarChooserInteractor.self), configuration: { [unowned self] (definition) -> Void in
            definition.injectProperty("output", with: self.avatarChooserPresenter())
            })
    }
    
}

func mainStoryboard() -> UIStoryboard {
    return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
}
