-- get the metatdata for raw air temp
select * from tables.seriescatalog ser
	full join tables.sources so 
		on ser.sourceid = so.sourceid
	full join tables.isometadata meta
                on meta.metadataid = so.metadataid


where lower(variablename) like 'temperature' and lower(samplemedium) like 'air' 

	