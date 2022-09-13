//
//  SceneDelegate.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var coordinator: AppCoordinator?
    private let persistenceController = PersistenceController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { fatalError("Unable to find window.") }
        coordinator = AppCoordinator(window: window, viewContext: persistenceController.container.viewContext)
        coordinator?.start()
        window.makeKeyAndVisible()
    }
}
