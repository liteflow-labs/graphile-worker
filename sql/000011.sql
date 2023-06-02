DROP TRIGGER _900_notify_worker ON graphile_worker.jobs;
CREATE TRIGGER _900_notify_worker AFTER INSERT ON graphile_worker.jobs FOR EACH ROW EXECUTE PROCEDURE graphile_worker.tg_jobs__notify_new_jobs();

CREATE OR REPLACE FUNCTION graphile_worker.tg_jobs__notify_new_jobs() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify('jobs:insert', new.id::text);
  return new;
end;
$$;
