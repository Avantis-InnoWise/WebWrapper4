import Foundation

//MARK: - HomeViewModel

final class HomeViewModel {
    
    private let url: URL
    
    //MARK: - Init
    
    init(url: URL) {
        self.url = url
    }
}

//MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    
    func downloadingWeb(with: (URLRequest) -> ()) {
        let request = URLRequest(url: url)
        with(request)
    }
}
