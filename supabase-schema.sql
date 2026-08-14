-- Sleep & Mind Lab: tabla de registros diarios sincronizados por cuenta.
-- Cada fila es un día de una persona. RLS asegura que cada quien solo
-- pueda leer y escribir sus propios registros -- ni siquiera con la clave
-- pública (anon) se puede ver el dato de otro usuario.

create table public.days (
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  sleep numeric,
  quality smallint,
  reaction integer,
  memory smallint,
  attention smallint,
  updated_at timestamptz not null default now(),
  primary key (user_id, date)
);

alter table public.days enable row level security;

create policy "propio_select" on public.days for select
  using (auth.uid() = user_id);
create policy "propio_insert" on public.days for insert
  with check (auth.uid() = user_id);
create policy "propio_update" on public.days for update
  using (auth.uid() = user_id);
create policy "propio_delete" on public.days for delete
  using (auth.uid() = user_id);
