﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<%-- <link rel="stylesheet" href="<%=cp%>/resource/css/article.css" type="text/css"> --%>
<link rel="stylesheet" href="<%=cp%>/resource/css/buddy2.css" type="text/css">

<script type="text/javascript">

function deleteBuddy() {
	var q = "buddyNum=${dto.buddyNum}&${query}";
	var url = "<%=cp%>/buddy/delete?" + q;

	if(confirm("메일을 삭제 하시 겠습니까 ? ")){
		  	location.href=url;
	}
}

function updateBuddy() {
	  var q = "buddyNum=${dto.buddyNum}&page=${page}";
	  var url = "<%=cp%>/buddy/update?" + q;

	  location.href=url;
}

function ajaxJSON(url, method, query, fn) {
	$.ajax({
		type: method, 
		url: url,
		data: query,
		dataType: "json",
		success: function(data){
			fn(data);
		}, 
		beforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}, 
		error: function(jqXHR) {
			if(jqXHR.state==403) {		// 로그인이 안됐으면 
				login(); 
				return false;
			} 			
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxHTML(url, method, query, selector) {
	$.ajax({
		type: method, 
		url: url,
		data: query,
		success: function(data){
			$(selector).html(data);
		}, 
		beforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}, 
		error: function(jqXHR) {
			if(jqXHR.state==403) {		
				login(); 
				return false;
			} 			
			console.log(jqXHR.responseText);
		}
	});	
}

</script>


<div style="margin-top: 10px; float: left; width: 500px; height: 700px;">
			<table class="articleTable">
			<tr align="left" height="40"  > 
			      <td class="typeTd" colspan="2" style="font-size: 14px;">	     	 
			
			   	  
			 	  
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 		
			      	${dto.sDate} ${page}
			      </td>
			</tr>		
			 		
			 <tr align="left" height="50"> 
				 <td class="titleTd" colspan="2" style="color: #632A7E; font-weight: bold; font-size: 20px;">
				 	<c:if test="${dto.buddyState==0}">				 
				 		<i class="far fa-star"></i> ${dto.title}  
				 	</c:if>
				 	<c:if test="${dto.buddyState!=0}">				 
				 		<i class="fas fa-star" style="color:#632A7E; " ></i> ${dto.title}  
				 	</c:if>
				</td>   
			 </tr>		 	
			
			<tr height="25" style="">
			    <td colspan="2" class="nameTd" align="left">
			      	보낸 사람 : ${dto.dType}&nbsp;${dto.name}&nbsp;${dto.pType} [${dto.email}]      	
			    </td>			   
			</tr>
			<tr height="30" style="border-bottom: 1px solid #E6E6E6;">
				 <td colspan="2" class="nameTd" align="left" style="padding-bottom: 10px;">
		      		받는 사람 : ${sessionScope.employee.dType}&nbsp;${sessionScope.employee.name}${sessionScope.employee.pType} [${sessionScope.employee.email}]
		  	    </td>
			</tr>
			
			<c:if test="${dto.fileCount!=0}">
			<tr>
				<td class="fileTd" colspan="2" align="left" style="font-size: 14px;"> <i class="fas fa-save"></i> 첨부 자료 ${dto.fileCount}개  </td>
			</tr>
			
			<tr> 
				<td colspan="2" style="padding-top: 0px; padding-bottom: 10px; border-bottom: 1px solid #cccccc; height: 30px;"> 
				<c:forEach var="vo" items="${listFile}">				
						<a href="<%=cp%>/buddy/download?fileNum=${vo.fileNum}" style="font-size: 17px;   border: 1px solid #cccccc; border-radius: 5px; padding: 3px 6px; margin-left: 10px;"> <span style="font-size: 13px;">
						${vo.originalFilename} </span> </a> 
				</c:forEach>
				</td>
			</tr>
			</c:if>	
				
			<tr>
			  <td class="contentTd" colspan="2" align="left" valign="top" style="border-bottom: none;">
			      ${dto.content}
			  </td>
			</tr>	
			
			<tr> 			
				<td rowspan="6" style="width: 18%; border-bottom: 1px solid #cccccc;  padding: 10px 0; padding-left: 3px; padding-top: 45px; padding-right: 5px;">
					<img src="<%=cp%>/uploads/profile/${dto.imageFilename}" width="150" height="150" border="0"> 
				</td>
				<td style="font-size: 15px;"> &nbsp; </td>
			</tr>
			<tr>
				<td style="font-weight: bold; font-size: 18px; border-bottom: 1px solid #cccccc; padding-left: 10px;"> <i class="fas fa-warehouse"></i>&nbsp; Mamp connect </td>
			</tr>
			<tr> 
				<td style="font-size: 15px; padding-top: 3px; padding-left: 10px;"><i class="fas fa-user-alt"></i>&nbsp;&nbsp;${dto.name} </td>
			</tr>
			<tr>
				<td style="font-size: 15px; padding-left: 10px;"><i class="fas fa-crosshairs"></i>&nbsp;&nbsp;${dto.dType} &nbsp; ${dto.pType} </td>
			</tr>
			<tr>
				<td style="font-size: 15px; padding-left: 10px;">&nbsp;<i class="fas fa-mobile-alt"></i>&nbsp;&nbsp;${dto.tel}  </td>
			</tr>				
			<tr>
				<td style="border-bottom: 1px solid #cccccc; padding-bottom: 8px; padding-left: 10px;"><i class="fas fa-envelope"></i>&nbsp;&nbsp;${dto.email}  </td>
			</tr>
			</table>	
			
         </div>
