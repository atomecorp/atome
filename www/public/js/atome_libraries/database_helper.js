class DatabaseHelper {
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