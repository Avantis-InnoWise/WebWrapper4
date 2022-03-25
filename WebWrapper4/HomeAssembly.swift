import Cocoa

//MARK: - HomeViewModelProtocol

protocol HomeViewModelProtocol: AnyObject {
    func downloadingWeb(with: (_ request: URLRequest) -> ())
}

//MARK: - HomeInput

struct HomeInput {
    let url: URL
}

//MARK: - HomeAssembly

final class HomeAssembly {
    let viewController: HomeViewController
    
    class func assembly(withInput input: HomeInput) -> HomeAssembly {
        let viewModel = HomeViewModel(url: input.url)
        let viewController = HomeViewController(with: viewModel)
        return HomeAssembly.init(viewController: viewController)
    }

    private init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}
