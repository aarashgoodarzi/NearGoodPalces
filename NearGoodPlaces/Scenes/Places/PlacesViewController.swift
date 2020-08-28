//
//  PlacesViewController.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlacesViewController: UIViewController {
    
    
    //MARK: - Outlets and vars
    let disposeBag = DisposeBag()
    var viewModel = PlacesViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    
    
    //MARK: - Actions
    
    
    //MARK: - Methods
    func setupUI() {
        prepareTableView()
        prepareNavBar()
    }
    
    //**
    func prepareNavBar() {
        self.navigationItem.title = "Near Good places"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    //**
    func prepareTableView() {
        tableView.tableFooterView = UIView()
    }
    
    //end of class
}

// MARK: - Bindings
extension PlacesViewController {
    
    //Mark: setupBindings
    func setupBindings() {
        bindIsIndicatorAnimating()
        bindList()
        bindListDidSelect()
    }
    
    //**
    func bindIsIndicatorAnimating() {
        viewModel.isIndicatorAnimating.subscribe(onNext: {
            isIndicatorAnimating in
            
        }).disposed(by: disposeBag)
    }

    //MARK: List Bindings
    func bindList() {
        viewModel.list.bind(to: tableView.rx.items(cellIdentifier: PlaceCell.getReuseIdentifier, cellType: PlaceCell.self)) { [weak self] (row, item, cell) in
            guard let self = self else {
                return
            }
            cell.set(item: item)
            self.viewModel.listReached(at: row)
        }.disposed(by: disposeBag)
    }
    
    func bindListDidSelect() {
        tableView.rx.itemSelected.subscribe(onNext: { [weak self](indexPath) in
            self?.viewModel.didSelectItem(at: indexPath.row)
        }).disposed(by: disposeBag)
    }
}
