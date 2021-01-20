//
//  ViewController.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import UIKit

class ChannelListCell: UITableViewCell {
    
    static let reuseIdentifier = "ChannelListCell"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class ChannelListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = L10n.ChannelListViewController.title
    }
}

extension ChannelListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelListCell.reuseIdentifier,
                                                       for: indexPath) as? ChannelListCell else {
            fatalError("You hooked it up wrong.")
        }
        
        return cell
    }
}
