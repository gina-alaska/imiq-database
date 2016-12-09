-- View: tables.datavaluesaggregate

-- DROP VIEW tables.datavaluesaggregate;

CREATE TABLE tables.datavaluesaggregate_2 AS 
 SELECT s.datastreamid,
    s.offsetvalue,
    s.offsettypeid,
    s.begindatetime,
    s.enddatetime,
    s.begindatetimeutc,
    s.enddatetimeutc,
    s.totalvalues,
    m.missingdatavaluestotal
   FROM ( SELECT datavalues.datastreamid,
            datavalues.offsetvalue,
            datavalues.offsettypeid,
            min(datavalues.localdatetime) AS begindatetime,
            max(datavalues.localdatetime) AS enddatetime,
            min(datavalues.localdatetime) - ((datavalues.utcoffset || 'hour'::text)::interval) AS begindatetimeutc,
            max(datavalues.localdatetime) - ((datavalues.utcoffset || 'hour'::text)::interval) AS enddatetimeutc,
            count(*) AS totalvalues
           FROM tables.datavalues
          WHERE datavalues.offsetvalue IS NOT NULL AND datavalues.offsettypeid IS NOT NULL
          GROUP BY datavalues.datastreamid, datavalues.offsetvalue, datavalues.offsettypeid, datavalues.utcoffset) s
     LEFT JOIN ( SELECT datavalues.datastreamid,
            datavalues.offsetvalue,
            datavalues.offsettypeid,
            count(*) AS missingdatavaluestotal
           FROM tables.datavalues
          WHERE datavalues.datavalue IS NULL AND datavalues.categoryid IS NULL
          GROUP BY datavalues.datastreamid, datavalues.offsetvalue, datavalues.offsettypeid) m ON m.datastreamid = s.datastreamid AND m.offsetvalue = s.offsetvalue AND m.offsettypeid = s.offsettypeid
UNION
 SELECT s.datastreamid,
    NULL::double precision AS offsetvalue,
    NULL::integer AS offsettypeid,
    s.begindatetime,
    s.enddatetime,
    s.begindatetimeutc,
    s.enddatetimeutc,
    s.totalvalues,
    m.missingdatavaluestotal
   FROM ( SELECT datavalues.datastreamid,
            min(datavalues.localdatetime) AS begindatetime,
            max(datavalues.localdatetime) AS enddatetime,
            min(datavalues.localdatetime) - ((datavalues.utcoffset || 'hour'::text)::interval) AS begindatetimeutc,
            max(datavalues.localdatetime) - ((datavalues.utcoffset || 'hour'::text)::interval) AS enddatetimeutc,
            count(*) AS totalvalues
           FROM tables.datavalues
          WHERE datavalues.offsetvalue IS NULL OR datavalues.offsettypeid IS NULL
          GROUP BY datavalues.datastreamid, datavalues.offsetvalue, datavalues.offsettypeid, datavalues.utcoffset) s
     LEFT JOIN ( SELECT datavalues.datastreamid,
            count(*) AS missingdatavaluestotal
           FROM tables.datavalues
          WHERE datavalues.datavalue IS NULL AND datavalues.categoryid IS NULL AND (datavalues.offsetvalue IS NULL OR datavalues.offsettypeid IS NULL)
          GROUP BY datavalues.datastreamid) m ON m.datastreamid = s.datastreamid;

--ALTER TABLE tables.datavaluesaggregate_2
--  ADD CONSTRAINT datavaluesaggregate_datastreamid PRIMARY KEY (datastreamid);

ALTER TABLE tables.datavaluesaggregate_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.datavaluesaggregate_2 TO imiq;
GRANT ALL ON TABLE tables.datavaluesaggregate_2 TO asjacobs;
GRANT ALL ON TABLE tables.datavaluesaggregate_2 TO chaase;
GRANT SELECT ON TABLE tables.datavaluesaggregate_2 TO imiq_reader;
GRANT ALL ON TABLE tables.datavaluesaggregate_2 TO rwspicer;
