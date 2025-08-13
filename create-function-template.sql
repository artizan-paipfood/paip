CREATE OR REPLACE FUNCTION public.build_aws_file_path(sufix_path text)
RETURNS text
LANGUAGE plpgsql
AS $function$
DECLARE
   path_result text;
BEGIN
   path_result := 'https://pub-e6f06fb0d25440d1a5afe5f8581988b6.r2.dev/' || sufix_path;

   RETURN path_result;
END;
$function$;