import UIKit
import PlaygroundSupport

private let _enabled = false

public enum Screenshot
{
    public static func capture(_ view: UIView) -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    public static func save(_ view: UIView, _ filename: String)
    {
        guard _enabled else { return }
        guard let image = capture(view) else { return }

        let fileURL = playgroundSharedDataDirectory.appendingPathComponent(filename)
        do {
            try UIImagePNGRepresentation(image)?.write(to: fileURL, options: .atomic)
            print("[saveScreenshot] success = \(fileURL)")
        }
        catch {
            print("[saveScreenshot] error = \(error)")
            print(
                "Make sure to create `$HOME/Documents/Shared Playground Data` directory first.",
                "See also http://nshipster.com/xcplayground/"
            )
        }
    }
}
