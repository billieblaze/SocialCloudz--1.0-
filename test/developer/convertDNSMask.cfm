<cffunction name="cfdump">
	<cfargument name="var">
	<cfdump var='#arguments.var#'>
</cffunction>
<cfscript>
	communityService = 	 createobject('component','/model/community/communityService').init(datasource='community',xmlDefinition="/model/community/community.xml");
	
	communities = communityService.gateway.get();
	cfdump(communities);

	for (i=1; i lte communities.recordcount; i=i+1){
		dnsMask = {
			id: 0,
			communityID: communities.communityID[i],
			subdomain: communities.subdomain[i],
			domain: 'socialcloudz.com',
			startpage:'/',
			verified: 1
		}
		cfdump(dnsMask);
		communityService.domain.saveMask(dnsMask);
	
		if (listlen(communities.dnsmask[i],'.') eq 3 and communities.subdomain[i] neq 'www' and communities.dnsmask[i] neq ''){
			dnsMask = {
				id: 0,
				communityID: communities.communityID[i],
				subdomain: listgetAt(communities.dnsmask[i],1,'.'),
				domain: listgetAt(communities.dnsmask[i],2,'.') & '.' & listgetAt(communities.dnsmask[i],3,'.'),
				startpage:'/',
				verified: 1
			}
			communityService.domain.saveMask(dnsMask);
			cfdump(dnsMask);
		}
	}
</cfscript>