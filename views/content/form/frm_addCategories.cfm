<cfoutput>
	<div class="ui-widget">
		<div class="ui-widget-header">Categories</div>
		<div class="ui-widget-content" align="center" style="padding: 5px 0px;">
			<div style="width:90%">
			<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
									gridName = 'contentCategories' 
									objectName = 'Category'	 
									rows="1000"
									height="200"
									method = 'application.content.category.list' 
									arguments = 'contentType=#event.getvalue('contentType')#&hasEntries=0' 
									defaultSort = 'category' 							
									paging='none'
									showAdd = 1
									addURL = '/index.cfm/content/categories/index/contentType/#event.getValue('contentType')#'
									showEdit = 1 
									editURL = '/index.cfm/content/categories/index/contentType/#event.getValue('contentType')#/ID/'										
									showDelete = 1
									showReload = 0
									deleteURL = '/index.cfm/content/categories/delete/ID/'	
									pid='#request.session.memberID#'
									datasource="community"
									isAdmin='0' 
			> 
			</div>
					<input type="hidden" id="categoryID" name="categoryID" value="#rc.categoryID#" />
			<script>
				var	listCategories = $('##categoryID').val();
				var	arrCategories = listCategories.split(',');
							
				categoryCheckbox = function(cellvalue, options, rowdata){ 
				  	src = '<input type="checkbox"  class="categoryID"  name="category" value="'+cellvalue+'"';
		
					for ( i = 0; i < arrCategories.length; i++) {
						if (arrCategories[i] == cellvalue){ src = src + ' checked'; } 
					}
				  
				  	src = src + '>';
				  	return src;
				}			
				
				
				$(document).ready(function(){
					$('##content').bind('submit', function (){
						var categorylist = '0';
						$('.categoryID:checked').each( function(){ 
							categorylist = categorylist + ',' + $(this).val();
						});
					 	$('##categoryID').val(categorylist);
					});
				});
				
				function afterShowAdd( ){
			 		$('##categoryForm').validate();
					$('##categoryForm').ajaxForm(function(responseText) { 
						jQuery("##contentCategories").trigger("reloadGrid");
				    }); 
				}
				
				function beforeUnloadAdd(){
				}
			</script>
	     </div>
	</div>
</cfoutput> 