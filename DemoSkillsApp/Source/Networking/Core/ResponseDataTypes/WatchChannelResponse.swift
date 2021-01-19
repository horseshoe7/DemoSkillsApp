//
//  GetChannelResponse.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation

public struct WatchChannelResponse: Codable, CustomDebugStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case stream
        case success
    }
    
    enum StreamKeys: String, CodingKey {
        case url
    }
    
    public let streamURL: URL
    public let wasSuccessful: Bool
    
    public init(from decoder: Decoder) throws {
        let rootLevelValues = try decoder.container(keyedBy: CodingKeys.self)
        wasSuccessful = try rootLevelValues.decodeIfPresent(Bool.self, forKey: .success) ?? false
        
        let streamContainer = try rootLevelValues.nestedContainer(keyedBy: StreamKeys.self, forKey: .stream)
        
        let urlString = try streamContainer.decode(String.self, forKey: .url)
        streamURL = URL(string: urlString)!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wasSuccessful, forKey: .success)
        
        var streamContainer = container.nestedContainer(keyedBy: StreamKeys.self, forKey: .stream)
        try streamContainer.encode(streamURL.absoluteString, forKey: .url)
    }
    
    public var debugDescription: String {
        return "WatchChannelResponse streamURL: \(streamURL.absoluteString)"
    }
}

/*
 
 EXAMPLE RESPONSE:
 {
     "tracking": {
         "latency_measurement_interval": 40,
         "event_pixel": "http://sandbox-hls-live.zahs.tv/event.gif?z32=ONUWOPLFHA2GIMJZGMZGMODBMU2DIMZTGU4GCMZQMJRWGZBUGFRDOYJSGUTGG43JMQ6TCNRUIY4UKRJQIFBDMOKGGVBUKLJSGU2DKMRRIJCTQRBVHA2TQRCG"
     },
     "success": true,
     "stream": {
         "rb_url": "http://hbbtv.zdf.de/zdfstart/index.php",
         "ad": {
             "vast_url": "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/40762806/prel-10-de/prel-10-video/prel-10-cs/prel-10-iphone/prel-10-zattoo&impl=s&gdfp_req=1&env=vp&unviewed_position_start=1&url=http%3A%2F%2Fzattoo.com%2F&description_url=http%3A%2F%2Fzattoo.com%2F&ad_rule=0&output=xml_vast2&correlator=409830807817217052&cust_params=titleprev%3DVolleyball%26uid%3Db3da66532cd14308a3d6f394ae0ab16f%26ab_test_groups%3D%26last_watch%3D45175%26random%3D5778078760758423334%26npa%3D0%26user_type%3Dfree%26email_valid%3D0%26genresnext%3DDrama%2CCrime%26titlenext%3DNotruf%20Hafenkante%26adid%3Dnull%26embed%3Dpartner_zapi%26user_consent%3D2%26channelprev%3Ddsf%26email_allowed%3D0%26asset_type%3Dlive%26categorynext%3DSeries%26category%3DSeries%2CEntertainment%26genres%3DTalk%20Show%26language%3Den%26title%3DVolle%20Kanne%20-%20Service%20t%C3%A4glich%26gender%3Dnone%26age%3Dnone%26categoryprev%3DSports%26account_age%3D604%26ad_h%3D9%26ad_group%3Dad_opt%26variantgroup%3D8%26appid%3D76%26forerun%3D12%26adcount%3D1%26clanguage%3Dde%26channel%3Dzdf",
             "type": "cs"
         },
         "event_pixel": "http://sandbox-hls-live.zahs.tv/event.gif?z32=ONUWOPLFHA2GIMJZGMZGMODBMU2DIMZTGU4GCMZQMJRWGZBUGFRDOYJSGUTGG43JMQ6TCNRUIY4UKRJQIFBDMOKGGVBUKLJSGU2DKMRRIJCTQRBVHA2TQRCG",
         "url": "http://sandbox-hls-live.zahs.tv/ZDF-live.m3u8?z32=NVQXQ4TBORST2MJVGAYSM5LTMVZF62LEHU2TKMBXGAZDQJTDONUWIPJRGY2EMOKFIUYECQRWHFDDKQ2FFUZDKNBVGIYUERJYIQ2TQNJYIRDCMZLOMNZHS4DUNFXW4PJQEZQXKZDJN5PWG33EMVRXGPLBMFRSM2LONF2GSYLMOJQXIZJ5GATHG2LHHU2GMODBHBTGCNBSGJSGMYRYG5QTIOJSGZSDAOBVGJRWIOJUHAYWMJTNNFXHEYLUMU6TA",
         "quality": "sd",
         "replay_seeking_allowed": false,
         "watch_urls": [
             {
                 "url": "http://sandbox-hls-live.zahs.tv/ZDF-live.m3u8?z32=NVQXQ4TBORST2MJVGAYSM5LTMVZF62LEHU2TKMBXGAZDQJTDONUWIPJRGY2EMOKFIUYECQRWHFDDKQ2FFUZDKNBVGIYUERJYIQ2TQNJYIRDCMZLOMNZHS4DUNFXW4PJQEZQXKZDJN5PWG33EMVRXGPLBMFRSM2LONF2GSYLMOJQXIZJ5GATHG2LHHU2GMODBHBTGCNBSGJSGMYRYG5QTIOJSGZSDAOBVGJRWIOJUHAYWMJTNNFXHEYLUMU6TA",
                 "maxrate": 1501,
                 "audio_channel": "A"
             },
             {
                 "url": "http://sandbox-hls-live.zahs.tv/ZDF~1-live.m3u8?z32=NVQXQ4TBORST2MJVGAYSM5LTMVZF62LEHU2TKMBXGAZDQJTDONUWIPJRGY2EMOKFIUYECQRWHFDDKQ2FFUZDKNBVGIYUERJYIQ2TQNJYIRDCMZLOMNZHS4DUNFXW4PJQEZQXKZDJN5PWG33EMVRXGPLBMFRSM2LONF2GSYLMOJQXIZJ5GATHG2LHHU4GCZLGGZQTIYZYGVQWKYRTGQ4DCYTBGQ4DMMRRGQYTANLCMMYTEJTNNFXHEYLUMU6TA",
                 "maxrate": 1501,
                 "audio_channel": "B"
             },
             {
                 "url": "http://sandbox-hls-live.zahs.tv/ZDF-live.m3u8?z32=NVQXQ4TBORST2NRQGETHK43FOJPWSZB5GU2TANZQGI4CMY3TNFSD2MJWGRDDSRKFGBAUENRZIY2UGRJNGI2TINJSGFBEKOCEGU4DKOCEIYTGK3TDOJ4XA5DJN5XD2MBGMF2WI2LPL5RW6ZDFMNZT2YLBMMTGS3TJORUWC3DSMF2GKPJQEZZWSZZ5HE4DAYJQGMZGCYZWMY3TIZRSGVSDSMJRG44GCZDFMI3DOOLBGQ3CM3LJNZZGC5DFHUYA",
                 "maxrate": 601,
                 "audio_channel": "A"
             },
             {
                 "url": "http://sandbox-hls-live.zahs.tv/ZDF~1-live.m3u8?z32=NVQXQ4TBORST2NRQGETHK43FOJPWSZB5GU2TANZQGI4CMY3TNFSD2MJWGRDDSRKFGBAUENRZIY2UGRJNGI2TINJSGFBEKOCEGU4DKOCEIYTGK3TDOJ4XA5DJN5XD2MBGMF2WI2LPL5RW6ZDFMNZT2YLBMMTGS3TJORUWC3DSMF2GKPJQEZZWSZZ5G5RTGZJQGQ4TGNJQGBQTQYRWGNSTMNBXMRSTCZTEMVQWGNBWGY3CM3LJNZZGC5DFHUYA",
                 "maxrate": 601,
                 "audio_channel": "B"
             }
         ],
         "teletext_url": "https://zattoo-abox.zattoo.com/assets/teletext.html?quality=sd&cid=zdf"
     },
     "register_timeshift": "unavailable",
     "csid": "164F9EE0AB69F5CE-254521BE8D5858DF",
     "unregistered_timeshift": "subscribable"
 }
 */
