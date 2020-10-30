import Kitura
import Cocoa

let router = Router()     //create router object
router.all("/ClaimService/add", middleware: BodyParser())
//let dbobj = Database.getInstance()

router.get("/ClaimService/getAll"){
    request, response, next in
    let pList = ClaimDao().getAll()
    //Json serialiation
    let jsonData : Data = try JSONEncoder().encode(pList)
    let jsonStr = String(data: jsonData, encoding: .utf8)
    
    response.send(jsonStr)
    
    next()
}
router.post("/ClaimService/add"){
    request, response, next in
    let body =  request.body
    let jObj = body?.asJSON
    if let jDict = jObj as? [String:String] {
        if let id1 = jDict["id"],let title1 = jDict["title"],let date1 =  jDict["date"]{
            if let jDict = jObj as? [String:Int] {
              //  let isSolved1 = jDict["isSolved"]
                let pObj = Claim(id1:id1,title1:title1,date1:date1,isSolved1:0)
                ClaimDao().addClaim(pObj: pObj)
                
            } else {
                
            }
            response.send ("The record was successfully inserted.(Post)")
            next()
    }
    
}

Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run()

}
