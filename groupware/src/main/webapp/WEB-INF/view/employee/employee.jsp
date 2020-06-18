<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/employee.css" type="text/css">

<script type="text/javascript">
	function employeeOk() {
		var f = document.employeeForm;
		var str;
		
		str = f.empNo.value;
		str = str.trim();
		
		if(!str) {
			alert("사원번호를 입력해주세요.");
			f.empNo.focus();
			return;
		}
		
		if(!/^[0-9]{5}$/i.test(str)) {
			alert("사원번호는 5자이며 숫자만 가능합니다.");
			f.empNo.focus();
			return;
		}
		
	/* 	f.empNo.value = str; */
		
		str = f.pwd.value;
		str = str.trim();
		if(!str) {
			alert("비밀번호를 입력해주세요.");
			f.pwd.focus();
			return;
		}
		
		if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
			alert("비밀번호는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
			f.pwd.focus();
			return;
		}
		
		f.pwd.value = str;

		/* 
		if(str!= f.pwdCheck.value) {
	        alert("비밀번호가 일치하지 않습니다.");
	        f.pwdCheck.focus();
	        return;
		}
		 */

	    str = f.name.value;
		str = str.trim();
	    if(!str) {
	        alert("이름을 입력해주세요.");
	        f.name.focus();
	        return;
	    }
	    f.name.value = str;

	    str = f.birth.value;
		str = str.trim();
	    if(!str || !isValidDateFormat(str)) {
	        alert("생년월일를 입력해주세요.[YYYY-MM-DD]");
	        f.birth.focus();
	        return;
	    }
	    
	    str = f.tel.value;
		str = str.trim();
	    if(!str) {
	        alert("전화번호를 입력해주세요.");
	        f.tel.focus();
	        return;
	    }
	    
	    var qwe = str.replace( /(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3" );
	    alert(qwe);

	    str = f.email.value;
		str = str.trim();
	    if(!str) {
	        alert("이메일을 입력해주세요.");
	        f.email.focus();
	        return;
	    }
	    
	    if(!/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i.test(str)) {
	    	alert("적합하지 않는 이메일 형식입니다.");
			f.email.focus();
			return;
	    }
	    
	    str = f.addr.value;
		str = str.trim();
	    if(!str) {
	        alert("주소를 입력해주세요.");
	        f.addr.focus();
	        return;
	    }
	    
	    str = f.dCode.value;
	    if(str == "") {
	    	alert("부서를 선택해주세요.");
	    	f.dCode.focus();
	    	return;
	    }
	    
	    str = f.pCode.value;
	    if(str == "") {
	    	alert("직위를 선택해주세요.");
	    	f.pCode.focus();
	    	return;
	    }
	    
	    str = f.enterDate.value;
		str = str.trim();
	    if(!str) {
	        alert("입사일자를 선택해주세요.");
	        f.enterDate.focus();
	        return;
	    }
	    
	    str = f.exitDate.value;
		str = str.trim();
	    if(!str) {
	        alert("퇴사일자를 선택해주세요.");
	        f.exitDate.focus();
	        return;
	    }
	    
	    str = f.apDate.value;
		str = str.trim();
	    if(!str) {
	        alert("발령일자를 선택해주세요.");
	        f.apDate.focus();
	        return;
	    }

	 	f.action = "<%=cp%>/employee/${mode}";
	 	
	   	f.submit();
	}


<%-- 	function empNoCheck() {
		var str = $("#empNo").val();
		str = str.trim();
		if(!/^[0-9]{5}$/i.test(str)) { 
			$("#empNo").focus();
			return;
		}
		
		var url="<%=cp%>/employee/empNoCheck";
		var q="empNo="+str;
		
		$.ajax({
			type:"post"
			,url:url
			,data:q
			,dataType:"json"
			,success:function(data) {
				var p=data.passed;
				if(p=="true") {
					var s="<span style='color:blue;font-weight:bold;'>"+str+"</span> 아이디는 사용 가능합니다.";
					$("#userId").parent().next(".help-block").html(s);
				} else {
					var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 아이디는 사용할 수 없습니다.";
					$("#empNo").parent().next(".help-block").html(s);
					$("#empNo").val("");
					$("#empNo").focus();
				}
			}
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});
		
	} --%>
</script>

<div class="container">
	<div class="testbox">
		<h1>${mode == "employee" ? "Register" : "Update"}</h1>

		<form name="employeeForm" method="post">
			<div id="div-one">
				<div id="div-one-right">
					<div>
						<label id="icon"><i class="fas fa-user"></i></label>
							<input type="text" name="empNo" id="empNo" placeholder="사원번호" maxlength="5" value="${dto.empNo}"  ${mode == "update" ? "readonly = 'readonly'" : ""} />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-lock"></i></label>
						<input type="password" name="pwd" placeholder="비밀번호" required />
					</div>
					
					<c:if test="${mode == 'update'}">
						<div>
						<label id="icon"><i class="fas fa-lock"></i></label>
							<input type="password" name="pwdCheck" placeholder="비밀번호확인" required />
						</div>
					</c:if>
					
					<div>
					<label id="icon"><i class="fas fa-signature"></i></label>
						<input type="text" name="name" placeholder="성명" required value="${dto.name}" ${mode == "update" ? "readonly = 'readonly'" : ""} />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-birthday-cake"></i></label>
						<input type="date" name="birth" placeholder="생년월일" maxlength="10" required value="${dto.birth}" />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-mobile-alt"></i></label>
						<input type="text" name="tel" placeholder="전화번호" required value="${dto.tel}" />
					</div>
					
					<div>
					<label id="icon"><i class="far fa-envelope-open"></i></label>
						<input type="text" name="email" placeholder="이메일" required value="${dto.email}" />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-home"></i></label>
						<input type="text" name="addr" placeholder="주소" required value="${dto.addr}" />
					</div>
				</div>
				
	
				<div id="div-two">
					<div class="selectGroup">
						<label id="icon"><i class="far fa-hand-rock"></i></label>
						<select class="selectBox" name="rCode">
							<option selected="selected" value="basic" ${dto.rCode=="basic"?"selected='selected'":"" }>기본</option>
							<option value="team" ${dto.rCode=="team"?"selected='selected'":"" }>팀장</option>
							<option value="admin" ${dto.rCode=="admin"?"selected='selected'":"" }>관리자</option>
						</select>
					</div>
					<div class="selectGroup">
						<label id="icon"><i class="fas fa-users"></i></label>
						<select class="selectBox" name="dCode">
							<option selected="selected" value="">::: 부서 :::</option>
							<option value="DV" ${dto.dCode=="DV"?"selected='selected'":"" }>개발부</option>
							<option value="PM" ${dto.dCode=="PM"?"selected='selected'":"" }>기획부</option>
							<option value="HR" ${dto.dCode=="HR"?"selected='selected'":"" }>인사부</option>
							<option value="PR" ${dto.dCode=="PR"?"selected='selected'":"" }>홍보부</option>
							<option value="TOP" ${dto.dCode=="TOP"?"selected='selected'":"" }>임원진</option>
							<option value="BM" ${dto.dCode=="BM"?"selected='selected'":"" }>경영지원부</option>
						</select>
					</div>
					
					<div class="selectGroup">
						<label id="icon"><i class="fas fa-layer-group"></i></label>
						<select class="selectBox" name="pCode">
							<option selected="selected" value="">::: 직위 :::</option>
							<option value="01" ${dto.pCode=="01"?"selected='selected'":"" }>사원</option>
							<option value="02" ${dto.pCode=="02"?"selected='selected'":"" }>대리</option>
							<option value="03" ${dto.pCode=="03"?"selected='selected'":"" }>과장</option>
							<option value="04" ${dto.pCode=="04"?"selected='selected'":"" }>부장</option>
							<option value="05" ${dto.pCode=="05"?"selected='selected'":"" }>이사</option>
							<option value="11" ${dto.pCode=="11"?"selected='selected'":"" }>부사장</option>
							<option value="12" ${dto.pCode=="12"?"selected='selected'":"" }>사장</option>
						</select>
					</div>
					
					<div>
						<label id="icon"><i class="fas fa-sign-in-alt"></i></label>
							<input type="date" name="enterDate" value="${dto.enterDate}"/>
					</div>
					
					<div>
						<label id="icon"><i class="fas fa-sign-out-alt"></i></label>
							<input type="date" name="exitDate" value="${dto.exitDate}"/>
					</div>
					
					<div>
						<label id="icon"><i class="fas fa-sync"></i></label>
							<input type="date" name="apDate" value="${dto.apDate}"/>
					</div>
					
					<div>
						<label id="icon"><i class="far fa-sticky-note"></i></label>
							<input type="text" name="memo" value="${dto.memo}"/>
					</div>
				</div>
			</div>
			<div id="buttonBox">
				<button type="button" name="sendButton" class="button" onclick="employeeOk();">${mode == "employee" ? "등록하기" : "정보수정"}</button>
				<button type="reset" class="button">다시입력</button>
				<button type="button" class="button" onclick="javascript:location.href='<%=cp%>/main';">${mode == "employee" ? "등록취소" : "수정취소"}</button>
				<c:if test="${mode=='update'}">
		        	 <input type="hidden" name="page" value="${page}">
		        </c:if>
			</div>
			<div>
				${message}
			</div>
		</form>
	</div>
</div>