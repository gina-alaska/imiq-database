-- Function: tables.calcwinddirection(real, real)

-- DROP FUNCTION tables.calcwinddirection(real, real);

CREATE OR REPLACE FUNCTION tables.calcwinddirection(
    x real,
    y real)
  RETURNS real AS
$BODY$
DECLARE value float;

BEGIN
-- vector components:
--    x, y
-- Offsets, used to go from vector back to radial:
--    if (x > 0  and y > 0) Offset=0
--    if (x < 0 ) Offset=180
--    if (x > 0) and y < 0) Offset=360
-- if x <> 0, and x and y are not null
--    Wind Direction = ARCTAN(y/x)*180/PI + Offset
-- else if x = 0
--    Wind Direction = 0
-- else
--    Wind Direction = null
  IF x is not null AND y is not null AND x != 0 THEN
    IF x >0 AND y > 0 THEN
      value := atan(CAST(y as double precision)/CAST(x as double precision))* 180.0/pi() + 0.0;
    ELSIF x < 0 THEN
      value := atan(CAST(y as double precision)/CAST(x as double precision))* 180.0/pi() + 180.0;
    ELSIF x > 0 and y < 0 THEN
      value := atan(CAST(y as double precision)/CAST(x as double precision))* 180.0/pi() + 360.0;
    END IF;
  ELSIF x = 0 THEN
    value := 0;
  ELSE
    value := NULL;
  END IF;

  RETURN value;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.calcwinddirection(real, real)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.calcwinddirection(real, real) TO public;
GRANT EXECUTE ON FUNCTION tables.calcwinddirection(real, real) TO imiq;
GRANT EXECUTE ON FUNCTION tables.calcwinddirection(real, real) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.calcwinddirection(real, real) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.calcwinddirection(real, real) TO chaase;
COMMENT ON FUNCTION tables.calcwinddirection(real, real) IS 'This function takes the x and y values from the uspgetdailywinddirection function and and calculates the direction from them.';
