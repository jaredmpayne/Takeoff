import Combine
import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(macOS 11.0, iOS 14.0, *)
internal class AsyncImageLoader: ObservableObject {
    
    #if os(macOS)
    public typealias ImageClass = NSImage
    #else
    public typealias ImageClass = UIImage
    #endif
    
    public let url: URL
    
    @Published public var image: ImageClass?
    
    private var cancellable: AnyCancellable?
    
    public init(url: URL) {
        self.url = url
    }
    
    deinit {
        self.cancellable?.cancel()
    }
    
    public func load() {
        self.cancellable = URLSession.shared.dataTaskPublisher(for: self.url)
            .map { ImageClass(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    public func cancel() {
        self.cancellable?.cancel()
    }
}
