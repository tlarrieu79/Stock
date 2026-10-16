-- À coller dans Supabase > SQL Editor > Run

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  created_at timestamptz not null default now()
);

create table if not exists public.items (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references public.categories(id) on delete set null,
  name text not null,
  qty integer not null default 0 check (qty >= 0),
  threshold integer not null default 0 check (threshold >= 0),
  updated_at timestamptz not null default now()
);

create index if not exists items_category_idx on public.items(category_id);

-- Sécurité : seuls les utilisateurs connectés lisent et modifient
alter table public.categories enable row level security;
alter table public.items enable row level security;

drop policy if exists "auth all categories" on public.categories;
drop policy if exists "auth all items" on public.items;

create policy "auth all categories" on public.categories
  for all to authenticated using (true) with check (true);
create policy "auth all items" on public.items
  for all to authenticated using (true) with check (true);

-- Temps réel (mise à jour automatique entre appareils)
alter publication supabase_realtime add table public.categories;
alter publication supabase_realtime add table public.items;
