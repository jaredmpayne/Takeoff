import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(macOS 11.0, iOS 14.0, *)
public struct AsyncImage<Placeholder: View>: View {
    
    /// The view to be displayed while the image is not loaded.
    public let placeholder: Placeholder?
    
    @ObservedObject private var asyncImageLoader: AsyncImageLoader
    
    #if os(macOS)
    private var imageInitializer = Image.init(nsImage:)
    #else
    private var imageInitializer = Image.init(uiImage:)
    #endif
    
    /// Creates an image asynchronously loaded from the given `URL`.
    /// - parameter url: The `URL` the image will be loaded from.
    /// - parameter placeholder: The `View` to display while the image is not loaded.
    public init(url: URL, placeholder: Placeholder? = nil) {
        self.asyncImageLoader = AsyncImageLoader(url: url)
        self.placeholder = placeholder
    }
    
    public var body: some View {
        Group {
            if let image = self.asyncImageLoader.image {
                imageInitializer(image)
                    .resizable()
            }
            else {
                self.placeholder
            }
        }
        .onAppear(perform: self.asyncImageLoader.load)
        .onDisappear(perform: self.asyncImageLoader.cancel)
    }
}

@available(macOS 11.0, iOS 14.0, *)
public struct AsyncImage_Previews: PreviewProvider {
    
    public static var previews: some View {
        AsyncImage(
            url: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/boat.png")!,
            placeholder: Text("Loading")
        )
        .frame(width: 200, height: 200)
    }
}
