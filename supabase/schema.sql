-- Family Grocery App — Supabase Schema
-- Run this in Supabase SQL Editor (supabase.com → SQL Editor)

-- Items table
create table if not exists items (
  id bigint primary key generated always as identity,
  name text not null,
  amount text default '',
  cat_id text default 'other',
  emoji text default '',
  photo text default '',
  done boolean default false,
  created_at timestamptz default now()
);

-- Categories table
create table if not exists categories (
  id text primary key,
  name text not null,
  icon text not null default '📦',
  color text not null default '#555',
  bg text not null default '#ebebeb'
);

-- Seed default categories
insert into categories (id, name, icon, color, bg) values
  ('fv',    'Fruits & Veggies', '🥬', '#3f6b2f', '#e3f0dc'),
  ('dairy', 'Dairy',            '🥛', '#2d5fa0', '#dae8f8'),
  ('pantry','Pantry',           '🫙', '#9e6018', '#f5e8d2'),
  ('meat',  'Meat & Fish',      '🍗', '#9e3030', '#f8dede'),
  ('bev',   'Beverages',        '☕', '#5e3f9e', '#ece5f8'),
  ('other', 'Other',            '📦', '#555',    '#ebebeb')
on conflict (id) do nothing;

-- Seed default items
insert into items (name, amount, cat_id, emoji, done) values
  ('Bananas',        '6 pcs',  'fv',    '🍌', true),
  ('Spinach',        '250 g',  'fv',    '🥬', true),
  ('Milk',           '1 L',    'dairy', '🥛', true),
  ('Eggs',           '12 pcs', 'dairy', '🥚', false),
  ('Rice',           '1 kg',   'pantry','🍚', false),
  ('Chicken Breast', '500 g',  'meat',  '🍗', false),
  ('Olive Oil',      '500 ml', 'pantry','🫒', false),
  ('Bread',          '1 loaf', 'other', '🍞', false),
  ('Apples',         '4 pcs',  'fv',    '🍎', false),
  ('Carrots',        '500 g',  'fv',    '🥕', true),
  ('Coffee',         '250 g',  'bev',   '☕', false),
  ('Pasta',          '500 g',  'pantry','🍝', true)
on conflict do nothing;

-- Enable realtime on items table (for live sync)
alter publication supabase_realtime add table items;