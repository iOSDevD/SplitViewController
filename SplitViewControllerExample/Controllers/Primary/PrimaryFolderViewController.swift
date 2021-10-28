//
//  PrimaryFolderViewController.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/16/21.
//

import UIKit
import os

class PrimaryFolderViewController: UIViewController {

    /// ViewModel for current controller i.e Main Folder
    private let viewModel:MainFolderViewModel
    
    /// UITableViewCell reuse identifier
    private static let folderCellIdentifier = "folderCellIdentifier"
    
    init(viewModel: MainFolderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var table: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addViews()
        setLayoutForMyViews()
        self.viewModel.fetchData()
    }

}

// MARK: -  Configure View
extension PrimaryFolderViewController {
    func addViews() {
        self.view.addSubview(table)
        self.table.register(UITableViewCell
                                .self, forCellReuseIdentifier: PrimaryFolderViewController.folderCellIdentifier)
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

// MARK: - Implement UITableViewDataSource
extension PrimaryFolderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionItemCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: PrimaryFolderViewController.folderCellIdentifier, for: indexPath)
        if let item = self.viewModel[indexPath] {
            cell.textLabel?.text = item
            cell.imageView?.image = UIImage(systemName: "folder.fill")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.header(for: section)
    }
}

// MARK: - Implement UITableViewDelegate
extension PrimaryFolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let logger = Logger()
        switch self.viewModel.itemSelected(at: indexPath) {
        case let (folder?,subFolder?):  // When both folder and File list is available, mainly prior to iOS 14. It updates the file list controller
            logger.debug("Folder SubFolder Handling \(folder),\(subFolder)")
            self.getFolderFilesUpdatable()?.reloadFileList(for: folder, subFolder: subFolder)
        case let(folder?,nil): // When only folder is avaialble, new triple column support. It updates the supplementary controller.
            print("Folder Handling \(folder)")
            self.getFolderListUpdatable()?.reloadFolderList(for: folder)

        default:
            print("Missing Selection Handling")
            break
        }
    }
}
