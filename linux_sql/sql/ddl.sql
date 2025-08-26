-- Step 1: switch to the host_agent database
\c host_agent;

-- Step 2: create host_info table if not exists
CREATE TABLE IF NOT EXISTS public.host_info (
  id               SERIAL PRIMARY KEY,
  hostname         VARCHAR NOT NULL UNIQUE,
  cpu_number       INT2    NOT NULL,
  cpu_architecture VARCHAR NOT NULL,
  cpu_model        VARCHAR NOT NULL,
  cpu_mhz          FLOAT8  NOT NULL,
  l2_cache         INT4    NOT NULL,      -- kB
  total_mem        INT4    NOT NULL,      -- kB
  "timestamp"      TIMESTAMP NOT NULL     -- UTC
);

-- Step 3: create host_usage table if not exists
CREATE TABLE IF NOT EXISTS public.host_usage (
  "timestamp"      TIMESTAMP NOT NULL,
  host_id          INT NOT NULL,
  memory_free      INT4 NOT NULL,
  cpu_idle         INT2 NOT NULL,
  cpu_kernel       INT2 NOT NULL,
  disk_io          INT4 NOT NULL,
  disk_available   INT4 NOT NULL,
  CONSTRAINT host_usage_pk PRIMARY KEY ("timestamp", host_id),
  CONSTRAINT host_usage_host_info_fk
    FOREIGN KEY (host_id) REFERENCES public.host_info(id)
);
