
# 📘 Documentation Complète : Architecture de la Base de Données

## 📌 Introduction
Ce document décrit l'architecture complète de la base de données utilisée pour stocker des objets dynamiques avec gestion fine des permissions, historisation des modifications et support avancé du partage et du prêt.

## 📌 Modèle de Données

### **1. Table `objects` (Stockage des Propriétés des Objets - Modèle EAV)**
Cette table stocke les objets sous forme de paires `propriété → valeur`, permettant une flexibilité maximale.

| Colonne         | Type       | Description |
|----------------|-----------|-------------|
| object_id      | TEXT (PK) | Identifiant unique de l’objet |
| property_name  | TEXT      | Nom de la propriété |
| property_value | TEXT      | Valeur stockée |
| updated_at     | DATETIME  | Date de la dernière modification |

**Exemple d’insertion :**
```sql
INSERT INTO objects (object_id, property_name, property_value)
VALUES ('a_123', 'type', 'element'),
       ('a_123', 'color', 'blue'),
       ('a_123', 'width', '300');
```

---

### **2. Table `history` (Suivi de Toutes les Modifications - Event Sourcing)**
Cette table permet d'enregistrer chaque modification appliquée à un objet.

| Colonne        | Type        | Description |
|---------------|------------|-------------|
| history_id    | INTEGER (PK) | Identifiant de l'événement |
| object_id     | TEXT        | ID de l’objet modifié |
| operation     | TEXT        | Type (`read`, `write`) |
| property_name | TEXT        | Propriété modifiée |
| old_value     | TEXT (NULL) | Ancienne valeur |
| new_value     | TEXT        | Nouvelle valeur |
| timestamp     | DATETIME    | Date et heure de la modification |

**Exemple d’insertion :**
```sql
INSERT INTO history (object_id, operation, property_name, old_value, new_value, timestamp)
VALUES ('a_123', 'write', 'width', '300', '400', '2025-02-28 14:00:00');
```

---

### **3. Table `permissions` (Gestion Granulaire des Droits)**
Cette table permet d’accorder des droits d’accès et de modification à un utilisateur sur un objet entier ou une propriété spécifique.

| Colonne        | Type        | Description |
|---------------|------------|-------------|
| permission_id | INTEGER (PK) | Identifiant de la permission |
| user_id       | TEXT        | ID de l’utilisateur |
| object_id     | TEXT        | ID de l’objet |
| property_name | TEXT (NULL) | Propriété concernée (NULL = tout l’objet) |
| permissions   | TEXT        | Types (`read`, `write`, `share`) |
| granted_by    | TEXT        | ID du créateur de la permission |
| timestamp     | DATETIME    | Date d’attribution du droit |

**Exemple d’insertion :**
```sql
INSERT INTO permissions (user_id, object_id, property_name, permissions, granted_by, timestamp)
VALUES ('u_001', 'a_123', 'color', 'write', 'u_002', '2025-02-28 14:05:00');
```

---

### **4. Table `shares` (Gestion du Partage et du Prêt)**
Cette table gère les partages d'objets entre utilisateurs, avec ou sans expiration.

| Colonne      | Type        | Description |
|-------------|------------|-------------|
| share_id    | INTEGER (PK) | Identifiant du partage |
| object_id   | TEXT        | ID de l’objet partagé |
| owner_id    | TEXT        | Propriétaire de l’objet |
| user_id     | TEXT        | Utilisateur bénéficiant du partage |
| can_delegate | BOOLEAN    | L’utilisateur peut-il prêter à d’autres ? |
| expiration  | DATETIME (NULL) | Date d’expiration du partage |

**Exemple d’insertion :**
```sql
INSERT INTO shares (object_id, owner_id, user_id, can_delegate, expiration)
VALUES ('a_123', 'u_001', 'u_003', TRUE, '2025-03-01 00:00:00');
```

---

## 📌 Échanges et API

### **1. Format des Requêtes**
Les échanges entre le client et le serveur se font sous forme de tableaux JSON contenant :
- **ID de l’objet**
- **Type d’opération (`read` ou `write`)**
- **Propriété concernée**
- **Nouvelle valeur (si écriture)**
- **Horodatage précis**

**Exemple d’envoi d’un client au serveur :**
```json
[
  ["a_123", "write", "color", "blue", "2025-02-28 13:28:33.230"],
  ["a_123", "write", "width", "300", "2025-02-28 13:28:37.927"]
]
```

---

## 📌 Sécurisation des Accès et des Modifications

1. **Transfert de propriété :** Lorsqu’un utilisateur vend un objet, l’ancien propriétaire **perd tous ses droits** sur l’objet et ne peut plus modifier les permissions.
2. **Cession partielle des droits :** Un utilisateur peut donner **l’accès à une seule propriété** à un autre utilisateur.
3. **Partage et prêt d’objets :** Les objets peuvent être partagés **avec ou sans sous-prêt** et **de manière temporaire ou définitive**.
4. **Gestion de l’unicité et des copies limitées :** Certains objets ont une **propriété `max_shares`** pour limiter leur duplication.

---

## 📌 Exemples de Scénarios et Solutions Implémentées

### **Scénario 1 : User 1 vend l’objet C à User 2**
✅ Solution : Mise à jour de `owner_id` dans `objects`, suppression des permissions existantes et transfert total des droits à User 2.

### **Scénario 2 : User 1 accorde uniquement le droit de modifier la couleur de l’objet B à User 3**
✅ Solution : Insertion d’une permission `write` uniquement sur `color` pour User 3.

### **Scénario 3 : User 1 prête un objet temporairement à User 4**
✅ Solution : Ajout d’un partage temporaire dans `shares`, avec une date d’expiration.

---

## 📌 Conclusion
Cette architecture garantit :
- **Flexibilité totale** grâce au modèle EAV.
- **Suivi complet des modifications** avec Event Sourcing.
- **Sécurisation avancée des droits** au niveau de chaque propriété.
- **Gestion du partage et des prêts** avec contrôle des délégations.

---
