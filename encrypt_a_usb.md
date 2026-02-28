## Encrypt USB key (from Euria)

Voici une méthode simple et sécurisée pour **chiffrer une clé USB sous Arch Linux** avec **LUKS (Linux Unified Key Setup)** — standard, fiable, intégré au noyau.

---

### 🛠️ Étapes pour chiffrer une clé USB avec LUKS

> ⚠️ **Attention : cette opération efface tout le contenu de la clé USB. Sauvegardez d’abord vos données !**

---

#### 1. Identifier le périphérique USB

```bash
lsblk
```

Recherchez votre clé USB (ex. : `/dev/sdb`, `/dev/sdc`).  
**Ne confondez pas avec votre disque dur principal !**

---

#### 2. Chiffrer la clé USB avec LUKS

```bash
sudo cryptsetup luksFormat /dev/sdX
```

> Remplacez `sdX` par le bon périphérique (ex. : `sdb`).

- Vous serez invité à saisir un **mot de passe fort** (minimum 12 caractères, mixtes).
- Confirmez-le.

---

#### 3. Ouvrir le volume chiffré

```bash
sudo cryptsetup open /dev/sdX encrypted_usb
```

> `encrypted_usb` = nom local du volume déchiffré (peut être n’importe quel nom).

---

#### 4. Formater le volume avec un système de fichiers (ex. : ext4)

```bash
sudo mkfs.ext4 /dev/mapper/encrypted_usb
```

---

#### 5. Monter le volume

```bash
sudo mkdir -p /mnt/usb
sudo mount /dev/mapper/encrypted_usb /mnt/usb
```

---

#### 6. Copier vos clés SSH

```bash
cp ~/.ssh/id_* /mnt/usb/
```

> (ou copiez les fichiers manuellement via un gestionnaire de fichiers)

---

#### 7. Démonter proprement

```bash
sudo umount /mnt/usb
sudo cryptsetup close encrypted_usb
```

---

### 🔐 Utilisation future

- Brancher la clé → ouvrir avec :

```bash
sudo cryptsetup open /dev/sdX encrypted_usb
sudo mount /dev/mapper/encrypted_usb /mnt/usb
```

- Démonter après usage :

```bash
sudo umount /mnt/usb
sudo cryptsetup close encrypted_usb
```

---

### ✅ Avantages
- Chiffrement AES-256 par défaut.
- Protection contre l’accès physique.
- Intégré à Linux, pas besoin d’installer de logiciel tiers.

---

### 💡 Astuce : automatiser le montage (optionnel)

Vous pouvez créer un script ou utiliser `crypttab` + `fstab` pour automatiser — mais **évitez de stocker le mot de passe en clair**.

---

> ✅ **Vous êtes maintenant protégé contre le vol de la clé USB.**  
> Même avec un mot de passe fort, le bruteforce reste théoriquement possible — mais **inpraticable en temps raisonnable**.

Si vous voulez, je peux vous aider à créer un script de montage/démontage sécurisé.
