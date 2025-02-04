//
//  AppetizerListViewModel.swift
//  AppetizerSwiftUI
//
//  Created by Fernando Archila on 05.06.24.
//

import Foundation
import SwiftUI

final class AppetizerListViewModel:ObservableObject{
    @Published  var appetizers:[Appetizer]=[]
    @Published  var alertItem: AlertItem?
    @Published  var isLoading:Bool = false
    @Published  var isShowingDetail = false;
    @Published  var selectedAppetizer:Appetizer?
    
    
    
    func getAppetizers(){
        isLoading = true
        NetworkManager.shared.getAppetizers {  [self] result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                switch result{
                    case .success(let appetizers):
                    self.appetizers = appetizers
                        break
                    case .failure(let error):
                        switch error{
                            case .invalidData:
                                alertItem = AlertContext.invalidData
                                break
                            case .invalidURL:
                                alertItem = AlertContext.invalidURL
                                break
                            case .invalidResponse:
                                alertItem = AlertContext.invalidResponse
                                break
                            case .unableToComplete:
                                alertItem = AlertContext.unableToComplete
                                break
                        }
                        break
                }
               
            }

        }
        
    }
    
}
