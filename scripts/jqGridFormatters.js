yesNoFormat = function(cellvalue, options, rowdata){ 
  var yn_result = 'no';
  if (cellvalue == '0'){ 
  	yn_result = 'No';
  } else { 
	yn_result = 'Yes';
 }
  
  return yn_result; 
}

photoFmatter = function(cellvalue, options, rowdata){ 
  src = ('<img src="' + cellvalue + '">');
  return src;
}

userFmatter= function(cellvalue, options, rowdata){
	  user = ('<a href="/index.cfm/member/profile/index/memberid/'+ rowdata['MEMBERID'] + '">' + cellvalue + '</a><BR><a class="xsmall" href="mailto:'+ rowdata['EMAIL'] + '">'+ rowdata['EMAIL'] + '</a><BR><span class="xsmall">Joined: <BR>'+rowdata['DATEENTERED']+'<BR>Last Online: <BR>'+rowdata['LASTCLICK']+'<BR></span>');
	  return user;
}
userPhotoFmatter = function(cellvalue, options, rowdata){ 
	  src = ('<img src="' + cellvalue + '"><BR><a href="/index.cfm/member/account/index/memberID/'+ rowdata['MEMBERID'] + '" class="xsmall">Edit Profile</a>');
	  return src;
	}

accessFormat= function(cellvalue, options, rowdata){ 
  var access_result = 'Member';
  if (cellvalue == '100'){ 
  	access_result = 'Support';
  } else if (cellvalue == '20'){ 
	access_result = 'Owner';
  } else if (cellvalue == '10'){ 
	access_result = 'Editor';
  } 
  return access_result;
}

categoryCheckbox= function(cellvalue, options, rowdata){ 
  	src = '<input type="checkbox"  class="categoryID"  name="category" value="'+cellvalue+'"';
	if(rowdata['SELECTED'] == 1){ 	src = src + ' checked'; } 
  	src = src + '>';
  	return src;
}

templateFormatter= function(cellvalue, options, rowdata){ 
	var url = "<a class='blackText' href='/index.cfm/emailTemplates/admin/form/id/" + rowdata['ID'] + "'>"+cellvalue+"</a>";
	return url;
}

checkFormatter= function(cellvalue,options,rowdata){
	src = ('<input type="checkbox" name="messageID" class="messageID" value="'+cellvalue+'">');
	return src;
}	