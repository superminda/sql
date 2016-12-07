$(function(){
	
	$("#switch-reg").click(function(){
		$(".loginForm").slideUp(200,function(){
			$(".registerForm").slideDown(400);
		});
	});

	$("#switch-login").click(function(){
		$(".registerForm").slideUp(200,function(){
			$(".loginForm").slideDown(400);
		});
	});
	
	function handleReturn(call) {
		switch (call) {
		case 'user_existed':
			indexShowTooltip('reg_user','Account Already Existed');
			break;
		case 'invalid_username_length':
			//alert("账号只能为4~20位的英文和数字！");
			 // $("#reg_user").val('');
			indexShowTooltip('reg_user','length must be 6-16  and only accept a-z, A-Z, 0-9, _ ');
			break;
		case 'invalid_username_character':
			//alert("账号只能为4~20位的英文和数字！");
			// $("#reg_user").val('');
			indexShowTooltip('reg_user','length must be 6-16  and only accept a-z, A-Z, 0-9, _ ');
			break;	
		case 'invalid_email_format':
			//alert("账号只能为4~20位的英文和数字！");
			// $("#reg_email").val('');
			indexShowTooltip('reg_email','email format should be valid.');
			break;	
		case 'repwd_not_equal':
			//alert("两次密码输入的不一样！");
			$("#reg_pwd").val('');
			$("#reg_repwd").val('');
			indexShowTooltip('reg_repwd','two different pwd enter');
			break;
		case 'invalid_pwd_length':
			$("#reg_pwd").val('');
			$("#reg_repwd").val('');
			indexShowTooltip('reg_repwd','pwd length should between 6-16');
			break;
		case 'invalid_pwd_character':
			$("#reg_pwd").val('');
			$("#reg_repwd").val('');
			indexShowTooltip('reg_repwd','invalid pwd format');
			break;
		 case 'signup_successful':
		 	location = "../user page/user.html?user="+ $("#reg_user").val(); 
		 	break;
		default:
			break;
		}
	}

 
	$("#register-button").click(function(){
		alert($("#reg_user").val());
		// alert($("#reg_email").val());
		// alert($("#reg_pwd").val());
		// alert($("#reg_repwd").val());

		$.ajax({
			url: "register.php",
			type: "POST",
			data: "user_name=" + $("#reg_user").val() + 
				  "&email=" + $("#reg_email").val() +
				  "&password=" + $("#reg_pwd").val() + 
				  "&repassword=" + $("#reg_repwd").val(),
			success: function(result) {
				handleReturn(result);
			}
		})
	})	
})

/**
 * tooltip显示错误内容
 * @param selector 何处显示错误(id名称)
 * @param errorInfo 错误信息
 */
function indexShowTooltip(selector,errorInfo){
	$("#"+selector).attr("title",errorInfo);
	$("#"+selector).tooltipster({
		trigger: 'custom',
		theme: 'tooltipster-noir',
		position: 'right'
	});
	// show a tooltip (the 'callback' argument is optional)
	$("#"+selector).tooltipster('show',function(){
		setTimeout(function(){
			$("#"+selector).tooltipster('hide');
		},2000)
	});
}

