class DatabaseHelper {
    constructor(databaseName) {
        this.db = new Dexie(databaseName);
    }

    createTable(tableName, fieldsNames) {
        const tableContent = {};
        tableContent[tableName] = fieldsNames;
        this.db.version(1).stores(tableContent);
    }

    addRow(table, fields) {
        this.db.table(table).put(fields);
    }

    addUser(content) {
        this.db.user.put(content);
    }

    addDocument(content) {
        this.db.document.put(content);
    }

    getDocumentsByUser(user_id) {
        return this.db.document
            .where('user_id')
            .equals(user_id).toArray().then(function (document) {
                for (const [key, value] of Object.entries(document)) {
                    Opal.Object.$result(Object.entries(value));
                }
            });
    }

    getDocumentById(id) {
        return this.db.document
            .where('id')
            .equals(id).toArray().then(function (document) {
                for (const [key, value] of Object.entries(document)) {
                    Opal.Object.$result(Object.entries(value));
                }
            });
    }

    updateDocumentById(id, content) {
        this.db.document
            .where('id')
            .equals(id)
            .modify({content: content});
    }

    deleteDocumentById(id) {
        this.db.document
            .where('id')
            .equals(id)
            .delete();
    }

    deleteDb() {
        this.db.delete();
    }
}


class SqliteHelper {
    constructor(databaseName, databaseEventListener) {
        this.databaseName = databaseName;
        this.databaseEventListener = databaseEventListener;
    }

    connect() {
        this.db = window.sqlitePlugin.openDatabase({name: this.databaseName, location:'default'});

        const self = this;
        this.db.transaction(function(tx) {
            self.createTableUser(tx);
            self.createUser(tx, 'Jeez', 'JeezPass');
        });

        this.databaseEventListener.onConnected();
    }

    createTableUser() {
        this.db.executeSql('CREATE TABLE IF NOT EXISTS user (login text primary key, password text)', function(result) {
            console.log('Table created or existing');
        });
    }

    createUser(login, password) {
        this.db.executeSql("INSERT INTO user (login, password) VALUES (?,?)", [login, password], function(tx, result) {
            console.log('inserted user ' + login + ' with id: ' + result.insertId);
        });
    }

    getAllUsers() {
        this.db.executeSql("select * from user;", [], function(tx, result) {
            console.log('Got ' + result.rows.length + ' users.');
        });
    }
}