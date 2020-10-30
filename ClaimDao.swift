//
//  ClaimDao.swift
//  RestServers
//
//  Created by CSUFTitan on 10/29/20.
//

//

import SQLite3

// JsonEncoder/JsonDecoder

struct Claim : Codable {
    
    var id : String
    var title : String?
    var date : String?
    var isSolved : Int
    init (id1 : String, title1 : String?, date1 : String?, isSolved1 : Int ){
        id = id1
        title = title1
        date = date1
        isSolved = 0
    
        
    }
}
class ClaimDao {
    func addClaim(pObj : Claim) {
        let sqlStmt = String(format:
            "Insert into person (id,title,date,isSolved) values ( '%@' , '%@' , '%@' , 0 )", pObj.id, (pObj.title)!, (pObj.date)!)
        
                // get database connection
        let conn = Database.getInstance().getDbConnection()
        //submit the insert sql statement
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK{
        let errcode = sqlite3_errcode(conn)
        print ("Failed to insert record \(errcode)")
    }
        sqlite3_close(conn)
  }
    
    func getAll() -> [Claim] {
        var pList = [Claim]()
        var resultSet : OpaquePointer?
    
        let sqlStr = "Select id,title,date,isSolved from Claim"
        let conn = Database.getInstance().getDbConnection()
        if sqlite3_prepare_v2(conn, sqlStr, -1, &resultSet, nil ) == SQLITE_OK {
            while (sqlite3_step(resultSet) == SQLITE_ROW){
       
                let id_val = sqlite3_column_text(resultSet, 0)
                let id1 = String(cString: id_val!)
                
                let title_val = sqlite3_column_text(resultSet, 1)
                let title1 = String(cString: title_val!)
                let date_val = sqlite3_column_text(resultSet, 2)
                let date1 = String(cString: date_val!)
                let isSolved_val = sqlite3_column_text(resultSet, 3)
                let isSolved1 = Int()
                pList.append(Claim (id1:id1,title1:title1,date1:date1,isSolved1:isSolved1 ))
            }
        }
        return pList
    }
    
}
