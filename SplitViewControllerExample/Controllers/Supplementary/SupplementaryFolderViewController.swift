//
//  SupplementaryFolderViewController.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/16/21.
//

import UIKit

protocol FolderListUpdatable {
    func reloadFolderList(for folderName: String)
}

class SupplementaryFolderViewController: UIViewController {

    /// UITableView show list of files for Supplementary Folder.
    private lazy var table: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    /// ViewModel for current controller i.e Supplementary Folder
    private let viewModel:SupplementaryFolderViewModel
    
    /// UITableViewCell reuse identifier
    private static let folderCellIdentifier = "folderCellIdentifier"
    
    private var folderList: [SubFolder]? {
        didSet {
            self.table.reloadData()
        }
    }
    
    /// Current folder name being selected.
    private var folderName: String? {
        didSet {
            if let name = folderName {
                self.folderList = self.viewModel.getSupplementaryFolderList(for: name)
            }
        }
    }
    init(viewModel: SupplementaryFolderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addViews()
        setLayoutForMyViews()
    }

}

// MARK: -  Configure View
extension SupplementaryFolderViewController {
    func addViews() {
        self.view.addSubview(table)
        self.table.register(UITableViewCell
                                .self, forCellReuseIdentifier: SupplementaryFolderViewController.folderCellIdentifier)
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


// MARK: - Implement FolderListUpdatable protocol
extension SupplementaryFolderViewController: FolderListUpdatable {
    func reloadFolderList(for folderName: String) {
        self.folderName = folderName
    }
}

// MARK: - Implement UITableViewDataSource
extension SupplementaryFolderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.folderList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SupplementaryFolderViewController.folderCellIdentifier, for: indexPath)
        if let subFolder = self.folderList?[indexPath.row] {
            cell.textLabel?.text = subFolder.folderName
            cell.imageView?.image = UIImage(systemName: "folder.fill")
        }
        return cell
    }
}

// MARK: - Implement UITableViewDelegate
extension SupplementaryFolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let(folder?,subFolder?) = self.viewModel.supplementaryFolderSelected(at: indexPath),
           let fileListUpdateable = self.getFolderFilesUpdatable(){
            fileListUpdateable.reloadFileList(for: folder, subFolder: subFolder)
        }
    }
}
