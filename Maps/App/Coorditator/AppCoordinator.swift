//
//  AppCoordinator.swift
//  Maps
//
//  Created by Илья Дунаев on 23.06.2022.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    
    override func start() {
        toAuth()
    }
    
    private func toAuth() {
        let coordinator = AuthCoordinator()
        addDependency(coordinator)
        coordinator.start()
    }
}
