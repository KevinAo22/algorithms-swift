import Foundation

public class OrientedGraph: CustomStringConvertible {
    public private(set) var nodes: [Node]
    
    public init() {
        self.nodes = []
    }
    
    @discardableResult public func addNode(_ label: String) -> Node {
        let node = Node(label)
        nodes.append(node)
        return node
    }
    
    public func addEdge(_ source: Node, neighbor: Node) {
        let edge = Edge(neighbor)
        source.neighbors.append(edge)
    }
    
    public var description: String {
        var description = ""
        
        for node in nodes {
            if !node.neighbors.isEmpty {
                description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"
            }
        }
        return description
    }
    
    public func findNodeWithLabel(_ label: String) -> Node {
        return nodes.filter { $0.label == label }.first!
    }
    
    public func duplicate() -> OrientedGraph {
        let duplicated = OrientedGraph()
        
        for node in nodes {
            duplicated.addNode(node.label)
        }
        
        for node in nodes {
            for edge in node.neighbors {
                let source = duplicated.findNodeWithLabel(node.label)
                let neighbour = duplicated.findNodeWithLabel(edge.neighbor.label)
                duplicated.addEdge(source, neighbor: neighbour)
            }
        }
        
        return duplicated
    }
}

extension OrientedGraph: Equatable {
    public static func == (lhs: OrientedGraph, rhs: OrientedGraph) -> Bool {
        return lhs.nodes == rhs.nodes
    }
}

