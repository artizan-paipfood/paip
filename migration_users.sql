-- Migração de dados da public.users_ para auth.users
-- Regras:
-- - Todos têm nome (full_name)
-- - Nem todos têm telefone (phone_number apenas se não for nulo/vazio)
-- - IDs são iguais entre as tabelas

UPDATE auth.users
SET
    raw_user_meta_data = (
        -- Preserva campos existentes e adiciona/atualiza os novos
        COALESCE(
            raw_user_meta_data,
            '{}'::jsonb
        ) || CASE
        -- Se tem telefone (phone não é nulo e não é vazio)
            WHEN pu.phone IS NOT NULL
            AND pu.phone != '' THEN jsonb_build_object(
                'full_name',
                pu.name,
                'phone_number',
                jsonb_build_object(
                    'dial_code',
                    pu.phone_country_code,
                    'number',
                    pu.phone
                )
            )
            -- Se não tem telefone, só inclui o nome
            ELSE jsonb_build_object('full_name', pu.name)
        END
    )
FROM public.users_ pu
WHERE
    auth.users.id = pu.id;

-- Query para verificar o resultado da migração
-- SELECT
--     au.id,
--     au.raw_user_meta_data,
--     pu.name,
--     pu.phone_country_code,
--     pu.phone
-- FROM auth.users au
-- JOIN public.users_ pu ON au.id = pu.id
-- ORDER BY au.id;

-- Query para contar quantos usuários foram migrados
-- SELECT
--     COUNT(*) as total_migrados,
--     COUNT(CASE WHEN au.raw_user_meta_data->>'phone_number' IS NOT NULL THEN 1 END) as com_telefone,
--     COUNT(CASE WHEN au.raw_user_meta_data->>'phone_number' IS NULL THEN 1 END) as sem_telefone
-- FROM auth.users au
-- JOIN public.users_ pu ON au.id = pu.id;