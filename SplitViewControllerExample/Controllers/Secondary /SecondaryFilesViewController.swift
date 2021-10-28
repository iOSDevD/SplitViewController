//
//  SecondaryFilesViewController.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/16/21.
//

import UIKit

protocol FolderFilesUpdatable {
    func reloadFileList(for folderName: String, subFolder: String)
}

/// Controller that displays the list of files.
/// For text file it will show document text file icon while for
/// image it will show photo icon.
class SecondaryFilesViewController: UIViewController {

    /// View Model for the current controller
    private let viewModel:FolderFileListViewModel
    
    /// UITableViewCell reuse identifier
    private static let folderCellIdentifier = "folderCellIdentifier"
    
    /// UITableView show list of files.
    private lazy var table: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        return table
    }()
    
    private var fileList:[String]? {
        didSet {
            self.table.reloadData()
        }
    }
    
    init(viewModel: FolderFileListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addViews()
        setLayoutForMyViews()
        self.viewModel.fetchData()
    }
}


// MARK: -  Configure View
extension SecondaryFilesViewController {
    func addViews() {
        self.view.addSubview(table)
        self.table.register(UITableViewCell
                                .self, forCellReuseIdentifier: SecondaryFilesViewController.folderCellIdentifier)
    }
    
    func setLayoutForMyViews(){
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.table.topAnchor.constraint(equalTo: guide.topAnchor),
            self.table.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            self.table.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            self.table.leadingAnchor.constraint(equalTo: guide.leadingAnchor)
        ])
    }
}

// MARK: - Implement UITableViewDataSource protocol
extension SecondaryFilesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: SecondaryFilesViewController.folderCellIdentifier, for: indexPath)
        if let item = self.fileList?[indexPath.row] {
            cell.textLabel?.text = item
            cell.imageView?.image = item.hasSuffix("png") ? UIImage(systemName: "photo") : UIImage(systemName: "doc.text")
        }
        return cell
    }
    
}


// MARK: - Implement FolderFilesUpdatable protocol
extension SecondaryFilesViewController: FolderFilesUpdatable {
    func reloadFileList(for folderName: String, subFolder: String) {
        self.fileList =  self.viewModel.getFileList(for: folderName, subFolderName: subFolder)
    }
}
