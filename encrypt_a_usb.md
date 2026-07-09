## Encrypt USB key (from Euria)

Voici une méthode simple et sécurisée pour **chiffrer une clé USB sous Arch Linux** avec **LUKS (Linux Unified Key Setup)** — standard, fiable, intégré au noyau.

### 🛠️ Étapes pour chiffrer une clé USB avec LUKS

> ⚠️ **Attention : cette opération efface tout le contenu de la clé USB. Sauvegardez d’abord vos données !**

#### 1. Identifier le périphérique USB en exécutant `lsblk`
#### 2. Chiffrer la clé USB avec LUKS
```bash
sudo cryptsetup luksFormat /dev/sdX
```
- Vous serez invité à saisir un **mot de passe fort** (minimum 12 caractères, mixtes) et à le confirmer.

#### 3. Ouvrir le volume chiffré
```bash
sudo cryptsetup open /dev/sdX encrypted_usb
```
> `encrypted_usb` = nom local du volume déchiffré (peut être n’importe quel nom).

#### 4. Formater le volume avec un système de fichiers (ex. : ext4)
```bash
sudo mkfs.ext4 /dev/mapper/encrypted_usb
```
#### 5. Monter le volume
```bash
# si nécessaire, créer un dossier
sudo mkdir -p /mnt/usb
sudo mount /dev/mapper/encrypted_usb /mnt/usb
```
#### 6. Copier vos clés SSH
```bash
cp ~/.ssh/id_* /mnt/usb/
```
#### 7. Démonter proprement
```bash
sudo umount /mnt/usb
sudo cryptsetup close encrypted_usb
```
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

### ✅ Avantages
- Chiffrement AES-256 par défaut.
- Protection contre l’accès physique.
- Intégré à Linux, pas besoin d’installer de logiciel tiers.
