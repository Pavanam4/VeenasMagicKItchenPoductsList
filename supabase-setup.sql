-- Run this in Supabase Dashboard > SQL Editor.
create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric(10,2),
  weight text default '',
  description text default '',
  image_url text default '',
  sort_order integer not null default 100,
  active boolean not null default true,
  created_at timestamptz not null default now()
);
alter table public.products enable row level security;
drop policy if exists "Public can view active products" on public.products;
create policy "Public can view active products" on public.products
for select using (active = true);
drop policy if exists "Authenticated admins can manage products" on public.products;
create policy "Authenticated admins can manage products" on public.products
for all to authenticated using (true) with check (true);

-- Seed the 8 catalogue items. Prices intentionally left NULL until entered in the admin panel.
insert into public.products (name, price, weight, description, image_url, sort_order) values
('Mango Achaar', null, '250 g', 'Traditional mango achaar made with select raw mangoes and aromatic spices.', 'images/mango.webp', 1),
('Lemon Dates Achaar', null, '', 'A tangy and gently sweet pickle combining lemon and dates.', 'images/lemon-dates.webp', 2),
('Beetroot Dates Achaar', null, '', 'A colourful, flavourful combination of beetroot and dates.', 'images/beetroot-dates.webp', 3),
('Ginger Achaar', null, '', 'A bold, aromatic ginger pickle.', 'images/ginger.webp', 4),
('Shadavari Achaar', null, '', 'A distinctive traditional pickle from our collection.', 'images/shadavari.webp', 5),
('Gooseberry Achaar', null, '', 'Amla pickle with a delicious tangy flavour.', 'images/gooseberry.webp', 6),
('Pineapple Achaar', null, '', 'A sweet-and-tangy pineapple pickle.', 'images/pineapple.webp', 7),
('Garlic Achaar', null, '', 'Aromatic garlic pickle with traditional spices.', 'images/garlic.webp', 8);
