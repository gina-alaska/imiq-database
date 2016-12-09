-- for getting tes metadata for summary air temp max table
select a.siteid, a.sitecode, a.sitename,  a.network, a.organization,
               lat, long, elev, start_date, end_date, contactname, phone, email, address, city, state, zipcode, citation, title, abstract, topiccategory, profileversion, metadatalink
            from
                (select distinct on (si.siteid) siteid, sitename, sitecode,
                        networkcode as network, organization, contactname, phone, email, address, city, so.state, zipcode, citation, title, abstract, topiccategory, profileversion, metadatalink
                    from tables.sites si
                        full join tables.sources so 
                            on si.sourceid = so.sourceid
                        full join tables.organizations o
                            on o.sourceid = so.sourceid
                        full join tables.networkdescriptions net 
                            on net.networkid = o.networkid
                        full join tables.isometadata meta
                            on meta.metadataid = so.metadataid
                    group by si.siteid, networkcode, organization, contactname, phone, email, address, 
				city, so.state, zipcode, citation, title, abstract, topiccategory, profileversion, metadatalink) as a
            join 
                (select distinct on (si.siteid) si.siteid, sitename, 
                    st_ymax(si.geolocation::geometry) as lat,
                    st_xmax(si.geolocation::geometry) as long,
                    st_zmax(si.geolocation::geometry) as elev,
                    min (utcdatetime) as start_date,
                    max (utcdatetime) as end_date
                from tables.sites si
                    join tables.daily_airtempmax tb 
                        on tb.siteid = si.siteid
                    where si.siteid in 
                        (select distinct (tb.siteid)
                            from tables.daily_airtempmax order by tb.siteid)
                    group by si.siteid) as b
                on a.siteid = b.siteid