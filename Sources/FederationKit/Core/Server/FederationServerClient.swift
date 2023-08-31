//
//  AnyFederationServerClient.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

//WIP
public protocol AnyFederationServerClient {
    //MARK: Auth
    func login(username: String,
               password: String,
               token2FA: String?) async -> String?
    func register(username: String,
                  password: String,
                  password_verify: String,
                  show_nsfw: Bool,
                  email: String?,
                  captcha_uuid: String?,
                  captcha_answer: String?,
                  honeypot: String?,
                  answer: String?
    ) async -> String?
    
    //MARK: Content
    func uploadImage(_ imageData: Data,
                     auth: String?) async -> FederatedMedia?
    func deleteImage(_ media: FederatedMedia,
                     auth: String?) async -> Bool
    
    //MARK: Create
    @discardableResult
    func createCommunity(_ title: String,
                         auth: String?) async -> FederatedCommunity?
    @discardableResult
    func createPost(_ title: String,
                    content: String,
                    url: String?,
                    body: String?,
                    community: FederatedCommunity,
                    auth: String?) async -> FederatedPostResource?
    func editPost(_ postId: Int,
                    title: String,
                    url: String?,
                    body: String?,
                    nsfw: Bool,
                    language_id: Int?,
                    auth: String?) async -> FederatedPostResource?
    
}
