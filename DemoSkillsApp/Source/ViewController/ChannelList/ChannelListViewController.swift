//
//  ViewController.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import UIKit

class ChannelLoadingCell: UITableViewCell {
    static let reuseIdentifier = "ChannelLoadingCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

class ChannelListCell: UITableViewCell {
    
    static let reuseIdentifier = "ChannelListCell"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lastWatchedLabel: UILabel!
    
    weak var viewModel: ChannelListItemTableCellModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.thumbnailImage.bind(listener: nil)
    }
}

extension ChannelListCell {
    func update(with vm: ChannelListItemTableCellModel) {
        
        self.titleLabel.text = vm.titleLabelText
        self.descriptionLabel.text = vm.descriptionLabelText
        
        
        self.thumbnailImageView.image = vm.thumbnailImage.value
        self.lastWatchedLabel.text = vm.lastWatched
        
        vm.thumbnailImage.bind {[weak self] (value) in
            if self?.titleLabel.text == vm.titleLabelText {
                self?.thumbnailImageView.image = value
            }
        }
        vm.loadImage()
    }
}

class ChannelListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ChannelListViewModel = ChannelListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // first set up some data bindings
        viewModel.channels.bind { [weak self] (_) in
            self?.viewModelUpdatedCollection()
        }
        
        self.title = viewModel.controllerTitle
        viewModel.viewDidLoad()  // then populate the view with data
        self.viewModelUpdatedCollection()
    }
    
    private func viewModelUpdatedCollection() {
        self.tableView.reloadData()
    }
}

extension ChannelListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.channels.value.count > 0 else {
            return 1
        }
        return viewModel.channels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard viewModel.channels.value.count > 0 else {
            guard let loadingCell = tableView.dequeueReusableCell(withIdentifier: ChannelLoadingCell.reuseIdentifier,
                                                                  for: indexPath) as? ChannelLoadingCell else {
                fatalError("You hooked it up wrong.")
            }
            loadingCell.titleLabel.text = viewModel.auxCellText
            loadingCell.activityIndicator.isHidden = viewModel.loadingError != nil
            return loadingCell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelListCell.reuseIdentifier,
                                                       for: indexPath) as? ChannelListCell else {
            fatalError("You hooked it up wrong.")
        }
        let channelVM = self.viewModel.channels.value[indexPath.row]
        cell.update(with: channelVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard viewModel.channels.value.count > 0 else {
            return
        }
        
        let channelVM = self.viewModel.channels.value[indexPath.row]
        self.watch(channel: channelVM)
    }
    
    func watch(channel: ChannelListItemTableCellModel) {
        
        log.info("Wants to watch channel with ID: \(channel.model.channelID)")
        
        let alert = UIAlertController(title: "Sorry!",
                                      message: "Not implemented.  This is just a demo app and not a very useful one.  Just _imagine_ watching the news.  :)",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
