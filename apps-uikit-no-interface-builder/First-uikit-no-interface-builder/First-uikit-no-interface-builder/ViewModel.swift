//
//  ViewModel.swift
//  First-uikit-no-interface-builder
//
//  Created by Mainul Dip on 1/12/25.
//

import Foundation
class ViewModel {
    struct Model {
        var result: String = ""
    }
    
    var model: Model = Model()
    
    var modelDidChange: () -> Void
    
    init(modelDidChange: @escaping () -> Void) {
        self.modelDidChange = modelDidChange
    }
    
    func didSelectAdd() {
        //update the data
        modelDidChange()
    }
    
    func didSelectSubtract() {
        
    }
}
