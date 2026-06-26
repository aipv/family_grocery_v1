# Family Grocery App

A shared grocery list app powered by Supabase (Postgres + real-time sync).

## Setup

### 1. Create a Supabase project
Go to [supabase.com](https://supabase.com), create a new project.

### 2. Run the database schema
In Supabase dashboard → **SQL Editor** → paste the contents of `supabase/schema.sql` → **Run**.

### 3. Add your credentials
```bash
cp .env_example .env
```
Edit `.env` and fill in your Supabase credentials:
```
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```
Get these from: Supabase → Settings → API.

### 4. Install and run
```bash
npm install
npm run dev
```

### 5. Access
- **Local:** http://localhost:8080
- **Network:** http://YOUR_PC_IP:8080 (find IP with `hostname -I`)

## Features
- ✅ Add / edit / delete grocery items
- ✅ Mark items as bought
- ✅ Filter by category (sidebar)
- ✅ Filter by status (All / To Buy / Bought)
- ✅ Real-time sync across all devices via Supabase Realtime
- ✅ Add custom categories
- ✅ Emoji icons per item
- ☑️ **No auth** — data is shared via the anon key (add auth later for multi-user safety)
