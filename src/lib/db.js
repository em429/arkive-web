import Database from 'better-sqlite3'
import { resolve as path_resolve } from 'path'
//import { env } from 'process'

const db = new Database(path_resolve(process.env.ARKIVE_DB_PATH), { fileMustExist: true })

export const run = function (sql, params) {
  return db.prepare(sql).run(params)
}

export const query = function (sql, params) {
  return db.prepare(sql).all(params)
}
