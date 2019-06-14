//
//  Home.swift
//  Landmarks
//
//  Created by Kittisak Phetrungnapha on 14/6/2562 BE.
//  Copyright © 2562 Apple. All rights reserved.
//

import SwiftUI

struct CategoryHome : View {
    var categories: [String: [Landmark]] {
        .init(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [Landmark] {
        landmarkData.filter { $0.isFeatured }
    }
    
    var body: some View {
        NavigationView {
            List {
                FeaturedLandmarks(landmarks: featured)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(categories.keys.sorted().identified(by: \.self)) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationButton(destination: LandmarkList()) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing:
                PresentationButton(
                    Image(systemName: "person.crop.circle")
                    	.imageScale(.large)
                    	.accessibility(label: Text("User Profile"))
                    	.padding(),
                    destination: Text("User Profile"))
            )
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    
    var body: some View {
        landmarks[0].image(forSize: 250).resizable()
    }
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
#endif
