//
//  File.swift
//  
//
//  Created by Ludovic Ollagnier on 28/06/2023.
//

import Foundation

public struct Requester {

    public let baseURL: URL
    private var decoder: JSONDecoder
    private var encoder: JSONEncoder

    public init(baseURL: URL, decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder()) {
        self.baseURL = baseURL
        self.decoder = decoder
        self.encoder = encoder
    }

    public func getAllRestaurants() async -> [Restaurant] {
        let route = "restaurants"

        do {
            let (data, _) = try await URLSession.shared.data(from: baseURL.appendingPathComponent(route))
            let restaurants = try decoder.decode([Restaurant].self, from: data)
            return restaurants
        } catch {
            return []
        }
    }

    public func add(restaurant: Restaurant) async -> Restaurant? {
        let route = "restaurants"

        var request = URLRequest(url: baseURL.appendingPathComponent(route))
        request.httpMethod = "POST"

        do {
            let encoded = try encoder.encode(restaurant)
            request.httpBody = encoded
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            let restaurant = try decoder.decode(Restaurant.self, from: data)
            return restaurant
        } catch {
            return nil
        }
    }

    public func setImage(_ imageData: Data, to restaurant: Restaurant) async -> Restaurant? {
        var multipart = MultipartRequest()

        multipart.add(key: "filename", value: "\(restaurant.id).png")

        multipart.add(
            key: "data",
            fileName: "\(restaurant.id).png",
            fileMimeType: "image/png",
            fileData: imageData
        )

        let route = "restaurants/\(restaurant.id)/upload-image"
        var request = URLRequest(url: baseURL.appendingPathComponent(route))
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let restaurant = try decoder.decode(Restaurant.self, from: data)
            print((response as! HTTPURLResponse).statusCode)
            print(String(data: data, encoding: .utf8)!)
            return restaurant
        } catch {
            print(error)
            return nil
        }
    }
}
