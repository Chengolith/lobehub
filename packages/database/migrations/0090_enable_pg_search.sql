
-- Optional pg_search extension.
-- Neon may list pg_search as available while blocking installation.

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM pg_available_extensions
        WHERE name = 'pg_search'
    ) THEN
        BEGIN
            CREATE EXTENSION IF NOT EXISTS pg_search;
        EXCEPTION
            WHEN insufficient_privilege
              OR feature_not_supported THEN
                RAISE NOTICE
                    'pg_search installation blocked; skipping optional extension';
        END;
    ELSE
        RAISE NOTICE
            'pg_search not available; skipping optional extension';
    END IF;
END
$$;
