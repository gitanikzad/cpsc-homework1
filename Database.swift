

//
//  Daabase.swift
//  RestServers
//
//  Created by G. Nkzad on 10/29/20
//
import SQLite3

class Database {
    static var dbObj : Database!
    let dbname = "/Users/csuftitan/Documents/ClaimDb.sqlite"
    var conn : OpaquePointer?
    //create constructor
    init (){
        // 1. create  connection
       
        if sqlite3_open(dbname , &conn) == SQLITE_OK {
            
            initializeDB()
            
            sqlite3_close(conn)
            
        } else {
                let errcode = sqlite3_errcode(conn)
                print ("Open database failed due to error \(errcode)")
            
            }
        }
    
        //2. create tables
    
    private func initializeDB(){
        let sqlStmt = "create table if not exists person (id text, title text, date text, isSolved int)"
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK{
            let errcode = sqlite3_errcode(conn)
            print ("Create table failed due to error \(errcode)")
        }
    }
    
    func getDbConnection () -> OpaquePointer? {
        var conn : OpaquePointer?
           if sqlite3_open(dbname , &conn) == SQLITE_OK {
                return conn
                 // create tables
              //   initializeDB()
                 
            
             } else {
                     let errcode = sqlite3_errcode(conn)
                     print ("Open database failed due to error \(errcode)")
            
        }
             
    return conn
}
    static func getInstance() -> Database {
        if dbObj == nil {
            dbObj = Database()
        }
        return dbObj
    }
}
