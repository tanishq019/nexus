create table if not exists public.feedback_signals (
  id uuid primary key default gen_random_uuid(),
  rating integer not null check (rating between 1 and 5),
  reaction text not null default 'Fire' check (reaction in ('Fire','Love','Neutral','Rage')),
  message text,
  created_at timestamptz not null default now()
);

alter table public.feedback_signals enable row level security;

drop policy if exists "Anyone can read feedback signals" on public.feedback_signals;
create policy "Anyone can read feedback signals"
on public.feedback_signals
for select
to anon
using (true);

drop policy if exists "Anyone can submit feedback signals" on public.feedback_signals;
create policy "Anyone can submit feedback signals"
on public.feedback_signals
for insert
to anon
with check (
  rating between 1 and 5
  and reaction in ('Fire','Love','Neutral','Rage')
);
