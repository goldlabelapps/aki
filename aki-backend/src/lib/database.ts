// abgeschottet-ki/aki-backend/src/lib/database.ts

import fs from 'fs';
import path from 'path';
import Database from 'better-sqlite3';
import { initDB } from './sql/initDB';

// Allow the DB path to be overridden via an environment variable so that
// Docker volumes and other deployment setups can point at an arbitrary location.
const dbPath = process.env.AKI_DB_PATH
  ? path.resolve(process.env.AKI_DB_PATH)
  : path.join(path.resolve(process.cwd(), '..'), 'aki.db');

const dbDir = path.dirname(dbPath);
if (!fs.existsSync(dbDir)) {
  fs.mkdirSync(dbDir, { recursive: true });
}

export const db = new Database(dbPath);

initDB(db);
