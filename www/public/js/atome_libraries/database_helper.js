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