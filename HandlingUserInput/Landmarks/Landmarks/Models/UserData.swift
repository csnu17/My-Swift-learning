//
//  UserData.swift
//  Landmarks
//
//  Created by Kittisak Phetrungnapha on 5/6/2562 BE.
//  Copyright © 2562 Apple. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class UserData: BindableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    var showFavoritesOnly = false {
        didSet {
            didChange.send(self)
        }
    }
    
    var landmarks = landmarkData {
        didSet {
            didChange.send(self)
        }
    }
}
