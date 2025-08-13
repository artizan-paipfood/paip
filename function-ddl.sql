CREATE OR REPLACE FUNCTION public.func_get_establishments_by_location(p_lat double precision, p_long double precision, p_radius_km double precision)
 RETURNS TABLE(establishment_id uuid, fantasy_name text, logo text, address jsonb, distance_km double precision)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  RETURN QUERY
  WITH distances AS (
    SELECT
      e.id::uuid AS establishment_id,
      e.fantasy_name::text AS fantasy_name,
      e.logo::text AS logo,
      row_to_json(a.*) AS address,
      ROUND((
        6371 * ACOS(
          LEAST(1, GREATEST(-1,
            COS(RADIANS(p_lat)) * COS(RADIANS(a.lat)) *
            COS(RADIANS(a.long) - RADIANS(p_long)) +
            SIN(RADIANS(p_lat)) * SIN(RADIANS(a.lat))
          ))
        )
      )::numeric, 2)::double precision AS distance_km
    FROM establishments e
    LEFT JOIN address a ON e.id = a.establishment_id
    WHERE a.lat IS NOT NULL AND a.long IS NOT NULL
  )
  SELECT
    d.distance_km
  FROM distances d
  WHERE d.distance_km <= p_radius_km
  ORDER BY d.distance_km ASC;
END;
$function$;