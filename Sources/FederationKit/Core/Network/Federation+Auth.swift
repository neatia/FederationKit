//
//  Federation+Auth.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public extension Federation {
    func login(username: String,
               password: String,
               token2FA: String? = nil) async -> String? {
        let jwt = await lemmy?.login(username: username,
                                     password: password,
                                     token2FA: token2FA)
        
        FederationLog("Login succeeded: \(jwt != nil)")
        //For other servers, we would need to edit their kit to provide some sort of data
        //to create the resource at this location
        
        if let resource = lemmy?.user?.federated {
            addUser(resource)
        }
        
        return jwt
    }
    static func login(username: String,
                      password: String,
                      token2FA: String? = nil) async -> String? {
        return await shared.login(username: username, password: password, token2FA: token2FA)
    }
    
    func register(username: String,
                  password: String,
                  password_verify: String,
                  show_nsfw: Bool,
                  email: String? = nil,
                  captcha_uuid: String? = nil,
                  captcha_answer: String? = nil,
                  honeypot: String? = nil,
                  answer: String? = nil
    ) async -> String? {
        return await lemmy?.register(username: username,
                                     password: password,
                                     password_verify: password_verify,
                                     show_nsfw: show_nsfw,
                                     email: email,
                                     captcha_uuid: captcha_uuid,
                                     captcha_answer: captcha_answer,
                                     honeypot: honeypot,
                                     answer: answer)
    }
    static func register(username: String,
                         password: String,
                         password_verify: String,
                         show_nsfw: Bool,
                         email: String? = nil,
                         captcha_uuid: String? = nil,
                         captcha_answer: String? = nil,
                         honeypot: String? = nil,
                         answer: String? = nil
    ) async -> String? {
        return await shared.register(username: username,
                                     password: password,
                                     password_verify: password_verify,
                                     show_nsfw: show_nsfw,
                                     email: email,
                                     captcha_uuid: captcha_uuid,
                                     captcha_answer: captcha_answer,
                                     honeypot: honeypot,
                                     answer: answer)
    }
}
