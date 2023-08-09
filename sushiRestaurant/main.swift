//
//  main.swift
//  sushiRestaurant
//
//  Created by Alireza Karimi on 2023-08-08.
//
// help by chatgpt to write the code 
import Foundation

func dfs(_ node: Int, _ graph: [Int: [Int]], _ sushiRestaurants: Set<Int>, _ visited: inout [Bool]) -> (Int, Int) {
    visited[node] = true
    var sushiCount = 0
    var totalDistance = 0
    
    for neighbor in graph[node, default: []] {
        if !visited[neighbor] {
            let (subSushiCount, subDistance) = dfs(neighbor, graph, sushiRestaurants, &visited)
            sushiCount += subSushiCount
            totalDistance += subDistance
        }
    }
    
    if sushiRestaurants.contains(node) {
        sushiCount += 1
    }
    
    return (sushiCount, totalDistance + sushiCount - 1)
}

func findMinimalTravelTime(_ n: Int, _ m: Int, _ sushiRestaurants: Set<Int>, _ connections: [(Int, Int)]) -> Int {
    var graph = [Int: [Int]]()
    
    for (a, b) in connections {
        graph[a, default: []].append(b)
        graph[b, default: []].append(a)
    }
    
    var visited = [Bool](repeating: false, count: n)
    let (_, totalDistance) = dfs(0, graph, sushiRestaurants, &visited)
    
    return totalDistance
}

func main() {
    let input1 = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input1[0]
    let m = input1[1]
    
    let sushiRestaurants = Set(readLine()!.split(separator: " ").map { Int($0)! })
    
    var connections = [(Int, Int)]()
    for _ in 0..<n-1 {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        connections.append((input[0], input[1]))
    }
    
    let result = findMinimalTravelTime(n, m, sushiRestaurants, connections)
    print(result)
}

main()


