-- Schema CRM Locanda Magna Sesterzi
-- Pensato per accogliere webhook da ElevenLabs (Sofia), WhatsApp/Meta ed email

-- Clienti: il cuore del sistema
create table clients (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  phone text unique,
  email text,
  instagram_handle text,
  first_seen_at timestamptz default now(),
  last_contact_at timestamptz default now(),
  status text default 'nuovo', -- nuovo, attivo, stabile, a_rischio
  notes text,
  tags text[] default '{}',
  created_at timestamptz default now()
);

-- Prenotazioni: collegate al cliente
create table reservations (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id) on delete cascade,
  reservation_date date not null,
  reservation_time time not null,
  party_size integer,
  special_requests text,
  source text default 'phone', -- phone, whatsapp, instagram, walk_in
  status text default 'confirmed', -- confirmed, cancelled, completed, no_show
  created_at timestamptz default now()
);

-- Interazioni: ogni contatto col cliente, su qualsiasi canale
create table interactions (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id) on delete cascade,
  channel text not null, -- phone, whatsapp, email, instagram, facebook
  direction text not null, -- inbound, outbound
  summary text,
  transcript text,
  raw_payload jsonb, -- payload originale del webhook (debug e riuso futuro)
  ai_sentiment text, -- positivo, neutro, negativo
  ai_suggestion text, -- suggerimento AI per il prossimo passo
  occurred_at timestamptz default now(),
  created_at timestamptz default now()
);

create index idx_reservations_client on reservations(client_id);
create index idx_reservations_date on reservations(reservation_date);
create index idx_interactions_client on interactions(client_id);
create index idx_interactions_channel on interactions(channel);
create index idx_clients_phone on clients(phone);
