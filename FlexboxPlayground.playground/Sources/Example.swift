import Foundation
import Flexbox

internal var _examples = [Example]()

public struct Example
{
    public let description: String
    public let node: Node
}

public func example(_ description: String, _ node: Node)
{
    _examples.append(Example(description: description, node: node))
}

public func fexample(_ description: String, _ node: Node)
{
    _examples.removeAll()
    example(description, node)
}
