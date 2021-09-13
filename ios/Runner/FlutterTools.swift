//
//  FlutterTools.swift
//  Runner
//
//  Created by yuhua on 2021/9/4.
//

import Foundation

class FlutterTools {
    
    var pid: Int?
    
    init(messenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: "FlutterCall", binaryMessenger: messenger)
        channel.setMethodCallHandler { call, result in
            if call.method == "getAppType" {
                SNGetApiUrlsTool.sharedInstance().baseURL = {
                    print("baseURL:" + SNGlobalShare.sharedInstance().baseUrl)
                    KYApiHttpTool.getNoHud1("/ios/app/souce", withParams: nil) { response in
                        let type = response["ptype"] as? Int
                        let param = [
                            "pid": type,
//                            "isother": 1
                        ]
                        print(param)
                        KYApiHttpTool.getNoHud1("/sys/app/getchannel", withParams: param) { response in
                            let name = response["channel_name"]
                            self.pid = response["pid"] as? Int
                            result(name);
                        } failure: { error in
                            result("");
                        }
                    } failure: { error in
                        result("");
                    }
                }
                SNGetApiUrlsTool.sharedInstance().getApiUrls()
            } else if call.method == "getWebURL" {
                KYApiHttpTool.get("/sys/ios/getweburl", withParams: ["pid": self.pid ?? 0]) { response in
                    let url = response["domain_url"]
                    result(url)
                } failure: { error in
                    result("")
                }

            }
        }
    }
    
    deinit {
        print("FlutterTools销毁了")
    }
}
