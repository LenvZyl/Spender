//
//  HomeViewController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var purchaseListViewModel: PurchaseListViewModel!
    
    var user : [String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user ?? "A")
        setView()
    }
    private func setView(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        fetchPurchases()
    }
    
    private func fetchPurchases(){
        self.purchaseListViewModel = PurchaseListViewModel([
            Purchase(amount: 101.0, date: "\(Date())", description: "Stuff"),
            Purchase(amount: 110.0, date: "\(Date())", description: "Fuel"),
            Purchase(amount: 120.0, date: "\(Date())", description: "Food"),
            Purchase(amount: 410.0, date: "\(Date())", description: "Other Stuff"),
            Purchase(amount: 110.0, date: "\(Date())", description: "Games")
        ])
        updateTableView()
    }
    func checkLogin(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let screen = storyboard.instantiateInitialViewController()
        self.present(screen!, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purchaseListViewModel == nil ? 0 : self.purchaseListViewModel.purchaseCount()
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as? PurchaseTableViewCell else {
            fatalError("Cell not found")
        }
        let purchaseViewModel: PurchaseViewModel = self.purchaseListViewModel.purchaseAt(indexPath.row)
        purchaseViewModel.description.asDriver(onErrorJustReturn: "").drive(cell.descriptionLabel.rx.text).disposed(by: disposeBag)
        purchaseViewModel.amount.asDriver(onErrorJustReturn: "").drive(cell.amountLabel.rx.text).disposed(by: disposeBag)
        purchaseViewModel.date.asDriver(onErrorJustReturn: "").drive(cell.dateLabel.rx.text).disposed(by: disposeBag)
        return cell
    }
    private func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
