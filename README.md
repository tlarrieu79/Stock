# Stocks – Cellule secourisme

Site statique (un seul `index.html`) + base Supabase. Aucun serveur à gérer.

## 1. Supabase

1. Crée un projet sur supabase.com (ou réutilise l'existant).
2. **SQL Editor** → colle le contenu de `schema.sql` → **Run**.
3. **Authentication → Users → Add user** : crée un compte (e-mail + mot de passe) pour chaque membre de l'équipe (coche « Auto confirm user »).
4. **Authentication → Sign In / Providers → Email** : désactive **Allow new users to sign up** (sinon n'importe qui pourrait se créer un compte).
5. **Project Settings → API** : note l'**URL du projet** et la clé **anon / public**.

## 2. Configuration

Dans `index.html`, remplace les deux valeurs du bloc `CONFIG` :

```js
SUPABASE_URL: "https://xxxx.supabase.co",
SUPABASE_ANON_KEY: "ta_cle_anon"
```

La clé `anon` est publique par conception : la sécurité vient des règles RLS du `schema.sql` (seuls les utilisateurs connectés lisent/écrivent). Ne mets **jamais** la clé `service_role` dans ce fichier.

## 3. GitHub Pages

1. Crée un dépôt GitHub et envoie-y `index.html`, `schema.sql`, `README.md`.
2. **Settings → Pages → Build and deployment** : Source = *Deploy from a branch*, branche `main`, dossier `/ (root)`.
3. Après une minute, le site est en ligne sur `https://<ton-compte>.github.io/<ton-depot>/`.

Alternatives équivalentes : Netlify ou Vercel (glisser le dossier / connecter le dépôt, aucun build nécessaire).

## Utilisation

- **+ Catégorie** : crée une catégorie (Pansements, Médicaments, Matériel…). Elles peuvent être renommées ou supprimées ; les articles d'une catégorie supprimée passent dans « Sans catégorie ».
- **+ Article** : nom, catégorie, quantité, **seuil d'alerte**.
- Alerte quand `quantité ≤ seuil` (orange), rupture à 0 (rouge). Le bandeau en haut liste tout ce qu'il faut réapprovisionner.
- Les modifications apparaissent en direct sur tous les appareils connectés.
