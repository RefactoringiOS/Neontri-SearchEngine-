//
//  MainListViewController.swift
//  Neontri
//
//  Created by KOVIGROUP on 07/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import UIKit
import AlamofireImage

class MainListViewController: UIViewController {
    private var tableView: UITableView = {
          let tableView = UITableView()
          return tableView
      }()
    private var itemsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    private var refreshControl: UIRefreshControl!
       
       //Data Source
       var searchResultsViewModel = SearchResultsViewModel()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           setUI()
           setTableView()
           
           itemsSearchBar.delegate = self
           tableView.dataSource = self
           tableView.delegate = self
           
           //Refresh table
           refreshControl = UIRefreshControl()
           refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh...")
           refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
           tableView.addSubview(refreshControl)
       }
       
       @objc func refreshTable(sender:AnyObject) {
           self.updateData()
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
   }

   // MARK: - Private
extension MainListViewController  {
       fileprivate func setUI() {
           if UserDefaults.standard.string(forKey: "access_token") == nil {
               let alert = UIAlertController(title: "Authorization", message: "Would you like to authorize?", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
                   HttpClient.sharedInstance.startOAuth2Login()
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
           
           let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
           self.navigationItem.backBarButtonItem = backButton
           navigationController?.navigationBar.barStyle = .blackTranslucent
           self.title = "Users and repositories"
           itemsSearchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50)
           itemsSearchBar.showsCancelButton = true
           itemsSearchBar.placeholder = "Input text"
           itemsSearchBar.tintColor = UIColor.CustomColors.darkBlue
           itemsSearchBar.searchBarStyle = UISearchBar.Style.default
           self.view.addSubview(itemsSearchBar)
       }
       
       fileprivate func setTableView() {
           tableView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
           tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cellUser")
           tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "cellRepository")
           tableView.keyboardDismissMode = .onDrag
           self.view.addSubview(tableView)
       }
       
       func updateData() {
           searchResultsViewModel.getGitHubItems(query: self.searchResultsViewModel.query) { [unowned self] (success) in
               if success {
                   self.tableView.reloadData()
                   if self.refreshControl != nil {
                       self.refreshControl.endRefreshing()
                   }
               } else {
                   if self.refreshControl != nil {
                       self.refreshControl.endRefreshing()
                   }
               }
           }
       }
   }

   // MARK: - UITableViewDataSource

   extension MainListViewController: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return searchResultsViewModel.numberOfRowsInSection
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cellIdentifier = searchResultsViewModel.viewModelTypeOfCell(at: indexPath.row)
           if cellIdentifier == "cellUser" {
               let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UserTableViewCell
               let currentUser = searchResultsViewModel.viewModelForCell(at: indexPath.row)
               cell.setUserData(user: currentUser as! UserCellViewModel)
               cell.accessoryType = .disclosureIndicator
               return cell
           } else {
               let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RepositoryTableViewCell
               let currentRepository = searchResultsViewModel.viewModelForCell(at: indexPath.row)
               cell.setRepositoryData(repository: currentRepository as! RepositoryCellViewModel)
               return cell
           }
       }
   }

   // MARK: -  UITableViewDelegate

   extension MainListViewController: UITableViewDelegate {
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let cellIdentifier = searchResultsViewModel.viewModelTypeOfCell(at: indexPath.row)
           if cellIdentifier == "cellUser" {
               let userPortfolioViewController = UserPortfolioViewController()
               userPortfolioViewController.userCellViewModel = searchResultsViewModel.viewModelForCell(at: indexPath.row) as? UserCellViewModel
               userPortfolioViewController.view.backgroundColor = .white
               navigationController?.pushViewController(userPortfolioViewController, animated: true)
           }
       }
   }

   // MARK: -  UISearchBarDelegate

   extension MainListViewController : UISearchBarDelegate {
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           itemsSearchBar.text = ""
           searchResultsViewModel.query = ""
           updateData()
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
           self.searchResultsViewModel.query = searchText
           NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchCompleted), object: nil)
           self.perform(#selector(searchCompleted), with: nil, afterDelay: 0.5)
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           self.itemsSearchBar.endEditing(true)
       }
       
       @objc func searchCompleted() {
           self.updateData()
       }
   }
