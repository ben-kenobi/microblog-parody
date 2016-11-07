
//
//  EmoticonTool.swift
//  day-43-microblog
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class EmoticonTool {
    let recentPath="recent.archive".strByAp2Doc()
    lazy var emore:NSRegularExpression = try! NSRegularExpression(pattern: "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]", options: [])

    lazy var bund:NSBundle={
        let b = iBundle("Emoticons.bundle")!
        return b
    }()
    lazy var recent:[Emoticon] = {
        guard let res = self.unArchiveRecent() else{
            return [Emoticon]()
        }
        return res
    
    }()
    
    lazy var emoticons:[[[Emoticon]]]={
        var emos=[[[Emoticon]]]()
        

        emos.append(self.divideEmos(self.recent))
        
        emos.append(self.divideEmos(self.listEmoticon("default/info.plist", bundle: self.bund)))
        emos.append(self.divideEmos(self.listEmoticon("emoji/info.plist", bundle: self.bund)))
        emos.append(self.divideEmos(self.listEmoticon("lxh/info.plist", bundle: self.bund)))
        
        return emos
    }()
    
    static let inst:EmoticonTool=EmoticonTool()
    
    private init(){
       
    }
    
    func saveRecent(emo:Emoticon){
    
        
        if let i = recent.indexOf(emo){
            recent.removeAtIndex(i)
        }
    
      
        recent.insert(emo, atIndex: 0)
        while recent.count > 20{
            recent.removeLast()
        }

        self.emoticons[0][0]=recent
        archiveRecent()
        
    }
    

    func emoByChs(chs:String)->Emoticon?{
//       let p = NSPredicate(format: "chs == %@", chs)

        for emos in emoticons{
            for ems in emos{
//                 print((ems as NSArray).filteredArrayUsingPredicate(p))
                for em in ems{
                    if let chs2 = em.chs{
                        if (chs as NSString).isEqualToString(chs2){
                            return em
                        }
                    }
                }
            }
        }
        return nil
        
    }
    
    
    func emoAttStrFromStr(str:String?)->(NSAttributedString?,[MatchResult]?){
        guard let text = str else{
            return (nil,nil)
        }
        let att = NSMutableAttributedString(string: text)
        
        let ary = emore.matchesInString(text, options: [], range: NSMakeRange(0, text.len))
        for obj in ary.reverse() {
            let chs = (text as NSString).substringWithRange(obj.range)
            if let emo = emoByChs(chs){
            att.replaceCharactersInRange(obj.range, withAttributedString:EmoAttach.attStrWithEmo(emo))
            }
        }
        
        var resary = [MatchResult]()
        resary+=addHLAtrToAstr(att,re: "@[^\\W]+")
        resary+=addHLAtrToAstr(att,re: "https{0,1}://[^\\s^\\u4e00-\\u9fa5]+")
        resary+=addHLAtrToAstr(att,re: "#[^#]+#")
        return (att,resary)
    }
    
    
    func addHLAtrToAstr(astr:NSMutableAttributedString,re:String)->[MatchResult]{
         var resary = [MatchResult]()
        do{
            let re = try NSRegularExpression(pattern: re, options: [])
            re.enumerateMatchesInString(astr.string, options: [], range: NSMakeRange(0, astr.length), usingBlock: { (res, flag, stop) -> Void in
                if let res=res{
                    astr.addAttribute(NSForegroundColorAttributeName, value: iColor(80,g:125,b:175), range: res.range)
                    resary.append(MatchResult(str: (astr.string as NSString).substringWithRange(res.range), range: res.range))
                }
            })
           
        }catch{
            iCommonLog("\(error)")
        }
        return resary
    }
    
    func emoAttStrFromStr2(str:String?)->(atr:NSAttributedString?,reses:[MatchResult]?){
        guard let text = str else{
            return (nil,nil)
        }
        let att = NSMutableAttributedString(string: text)
        
        var resAry:[MatchResult]=[MatchResult]()

        (text as NSString).enumerateStringsMatchedByRegex("\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]") { (idx, capturedStrPointer, capturedRangePointer, stop) -> Void in
            resAry.append(MatchResult(str: capturedStrPointer.memory as? String, range: capturedRangePointer.memory))
        }
        
        for res in resAry.reverse(){
            if let emo = emoByChs(res.str ?? ""){
                att.replaceCharactersInRange(res.range!, withAttributedString:EmoAttach.attStrWithEmo(emo))
            }
        }
        let ary = addLinkToAstr2(att)
        
        return (att,ary)
    }
    
    func addLinkToAstr2(astr:NSMutableAttributedString)->[MatchResult]{
        var ary=[MatchResult]()
        (astr.string as NSString).enumerateStringsMatchedByRegex("@[^\\W]+") { (idx, capturedStrPointer, capturedRangePointer, stop) -> Void in
            astr.addAttribute(NSForegroundColorAttributeName, value: iColor( 80, g: 125, b: 175), range: capturedRangePointer.memory)
            ary.append(MatchResult(str:capturedStrPointer.memory as? String,range:capturedRangePointer.memory ))
        }
        

        (astr.string as NSString).enumerateStringsMatchedByRegex("http://[^\\s^\\u4e00-\\u9fa5]+") { (idx, capturedStrPointer, capturedRangePointer, stop) -> Void in
            astr.addAttribute(NSForegroundColorAttributeName, value: iColor( 80, g: 125, b: 175), range: capturedRangePointer.memory)
            ary.append(MatchResult(str:capturedStrPointer.memory as? String,range:capturedRangePointer.memory ))
        }
        

        (astr.string as NSString).enumerateStringsMatchedByRegex("#[^#]+#") { (idx, capturedStrPointer, capturedRangePointer, stop) -> Void in
            astr.addAttribute(NSForegroundColorAttributeName, value:iColor( 80, g: 125, b: 175), range: capturedRangePointer.memory)
            ary.append(MatchResult(str:capturedStrPointer.memory as? String,range:capturedRangePointer.memory ))
        }
        return ary
    }

}

extension EmoticonTool{
    
    func archiveRecent(){
        NSKeyedArchiver.archiveRootObject(recent, toFile: recentPath)
    }
    
    func unArchiveRecent()->[Emoticon]?{
       return  NSKeyedUnarchiver.unarchiveObjectWithFile(recentPath) as? [Emoticon]
    }
    
    private func divideEmos(emos:[Emoticon])->[[Emoticon]]{
        var res = [[Emoticon]]()
        let page = (emos.count-1)/20+1

        for i in 0..<page{
            let loc=i*20
            let len=emos.count-loc
            let ar=(emos as NSArray).subarrayWithRange(NSMakeRange(loc, len > 20 ? 20 : len))
            res.append(ar as! [Emoticon])
        }
        return res
    }
    
    private func listEmoticon( path:String , bundle:NSBundle ) -> [Emoticon]{
        let prefix=path.componentsSeparatedByString("/")[0]
        let path = iRes(path, bundle: bundle)!
        let ary = NSArray(contentsOfFile:path )!
//        let loc=(path as NSString).rangeOfString("/", options: NSStringCompareOptions.BackwardsSearch).location
//        
//        let prefix=(path as NSString).substringToIndex(loc)
//        let prefix  =  (path as NSString).stringByDeletingLastPathComponent
        


        var res=[Emoticon]()
        for obj in ary{
            if let dict = obj as? [String:AnyObject]{
                let emo=Emoticon(dict: dict)
                emo.path=prefix
                res.append(emo)
                
            }
        }
        return res
    }
    
    
}



class MatchResult:NSObject{
    var str:String?
    var range:NSRange?
    init(str:String?,range:NSRange?){
        super.init()
        self.str=str
        self.range=range
    }
    
    
}
