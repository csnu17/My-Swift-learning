//
//  CategoryItem.swift
//  Landmarks
//
//  Created by Kittisak Phetrungnapha on 14/6/2562 BE.
//  Copyright © 2562 Apple. All rights reserved.
//

import SwiftUI

struct CategoryItem : View {
    var landmark: Landmark
    
    var body: some View {
        VStack(alignment: .leading) {
            landmark
                .image(forSize: 155)
                .renderingMode(.original)
                .cornerRadius(5)
            Text(landmark.name)
                .color(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

#if DEBUG
struct CategoryItem_Previews : PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: landmarkData[0])
    }
}
#endif
