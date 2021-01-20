//
//  ChannelListItemTableCellModel.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 20.01.21.
//

import Foundation
import UIKit

class ChannelListItemTableCellModel {
    
    var thumbnailImage = Box<UIImage?>(nil)
    
    var titleLabelText: String {
        return model.name
    }
    
    var descriptionLabelText: String {
        return model.channelDescription
    }
    
    var lastWatched: String {
        guard let lastWatched = model.lastWatchedAt else { return "" }
        return L10n.ChannelListViewTableCellModel.LastWatched.stringArg(lastWatched.timeAgo())
    }
    
    let model: ChannelListItem
    init(model: ChannelListItem) {
        self.model = model
    }
    
    func loadImage() {
        guard let url = self.model.thumbnailURL else {
            return
        }
        
        // we assume that we won't need to refresh it once we have it.
        guard thumbnailImage.value == nil else {
            return  // we have it, so don't need to load it again.
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.thumbnailImage.value = image
                    }
                }
            }
        }
    }
}
