//
//  ChannelListViewModel.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 20.01.21.
//

import Foundation

class ChannelListViewModel {
    
    let controllerTitle = L10n.ChannelListViewController.title
    //var channels: [ChannelListItemTableCellModel] = []
    
    let channels = Box([ChannelListItemTableCellModel]())
    
    var auxCellText: String {
        if let loadingError = loadingError {
            return "Error Loading Data"
        } else {
            return L10n.ChannelListViewController.loadingText
        }
    }
    var loadingError: Error?
    
    init() {}
    
    func viewDidLoad() {
        // have to fetch the channels here then map them to viewModels and then set that property.
        let request = DemoAPIRequest.getChannels
        APIClient.shared.sendRequestAndDecodeJSON(request) { [weak self] (result: APIResult<ChannelListResponse>) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let response):
                let models = response.channelList.map { (listItem) -> ChannelListItemTableCellModel in
                    return ChannelListItemTableCellModel(model: listItem)
                }
                self.loadingError = nil
                self.channels.value = models
                
            case .failure(let error):
                self.loadingError = error
                self.channels.value = []
            }
        }
    }
}
