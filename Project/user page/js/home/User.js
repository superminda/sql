var user_json;
var user_name;

function navClick(obj) {
	var action = obj.attr('id');
    var img_handle = obj;
    if (obj.attr('class') !== 'clickble select') {
        if (obj.attr("id") == 'btn_info') {
            if ($(".info_child").css('display') == 'block')
                $("#btn_info div img").attr('src', public_url + '/img/icon/down.png');
            else $("#btn_info div img").attr('src', public_url + '/img/icon/up.png');
            $(".info_child").slideToggle("100");
        } 
        else  if (obj.attr("id") == 'btn_comp') {//此if，点击竞赛管理，下拉/回收竞赛管理菜单，改变竞赛管理图标
            	if ($(".comp_child").css('display') == 'block')
                    $("#btn_comp div img").attr('src', public_url + '/img/icon/down.png');
                else $("#btn_comp div img").attr('src', public_url + '/img/icon/up.png');
                $(".comp_child").slideToggle("100");
        	}
        else {
            $(".nav a,.info_child a").removeClass("select");
            obj.addClass("select");
            icon_change(img_handle);
            // 在往info_container里面添加页面之前先清空。
            $(".info_container").empty();    
            
            // 根据action载入相应的page
            switch (action) {
                case 'btn_main':
                	location.hash = "#main";
                	loadMainPage();
                break;		
				case 'btn_profile':
                	location.hash = "#profile";
                	loadProfilePage();
                break;				
				case 'btn_friends':
                	location.hash = "#friends";
                	loadFriendControl()
                break;				
				case 'btn_message':
                	location.hash = "#message";
                	loadMyChatPage();
	            break;				
				case 'btn_search':
                	location.hash = "#search";
                	loadSearchPage();
                break;				
				case 'btn_posts':
                	location.hash = "#posts";
                	loadPostPage();
                break;
				case 'btn_notice':
                	location.hash = "#notice";
                	loadNoticePage();
                break;								
				case 'btn_base_info':
                	location.hash = "#information";
                	loadPersonalPage();
                break;				
				case 'btn_photo':
                	location.hash = "#photo";
                	loadPhotoPage();
                break;           	
				case 'btn_safe':
                	location.hash = "#safe";
                	loadSafePage();
	            break;					
                
                default: break;
          }
        }  
    }
}
   
function logout(){
	//alert("See you soon!");
	$('.theme-popover-mask').fadeIn(100);
	window.parent.myAlert("See you soon");
	$('.messagePopButton').click(function() {
		$.ajax({           	
				url: "../logout.php", 
				type: "POST",
				//data: "username=" + $("#login_user").val(),
				async:false,
				success: function (call) {
					location = "../logout/logout.html" 
				}
		});
		
	});
	return;	
}


function session_expired(){
	//alert("See you soon!");
	$('.theme-popover-mask').fadeIn(100);
	window.parent.myAlert("Session Exipred!");
	$('.messagePopButton').click(function() {
		$.ajax({           	
				url: "../logout.php",
				type: "POST", 
				//data: "username=" + $("#login_user").val(),
				async:false,
				success: function (call) {
					location = "../logout/logout.html"
				}
		});
		
	});
	return;	
}   

   
function loadMainPage() {
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='MainPage_frame' id='MainPage_frame'   \
		         src= '" + app_url_timeline +  "' seamless='seamless' scrolling='no'   \
         	 onload='this.height=MainPage_frame.document.body.scrollHeight'></iframe>");
	}
	
}



function loadProfilePage() {
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='Ability_frame' id='Ability_frame'   \
		         src= '" + app_url_profile + "' seamless='seamless' scrolling='no'   \
		        onload='this.height=Ability_frame.document.body.scrollHeight' style='height:720px' ></iframe>")			
	}

} 





function loadFriendControl()
{
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='SearchFriend_frame' id='SearchFriend_frame'   \
		         src= '" + app_url_friend + "' seamless='seamless' scrolling='no'   \
		         onload='this.height=SearchFriend_frame.document.body.scrollHeight' style='height:1046px;' ></iframe>")			
	}                         
}




function loadMyChatPage(){
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='MyChat_frame' id='MyChat_frame'   \
		         src= '" + app_url_chat + "' seamless='seamless' scrolling='no' \
		         onload='this.height=MyChat_frame.document.body.scrollHeight' style='height:720px'></iframe>")			
	}
}



function loadSearchPage() {
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='SearchPeople_frame' id='SearchPeople_frame'   \
		         src= '" + app_url_search + "' seamless='seamless' scrolling='no'   \
		         style='height:600px' ></iframe>");	
	}
}


function loadPostPage()
{
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='PostPage_frame' id='PostPage_frame'   \
		         src= '" + app_url_post + "' seamless='seamless' scrolling='no'   \
		         style='height:1640px;' ></iframe>")	
	}                         
}



function loadNoticePage()
{
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='NoticePage_frame' id='NoticePage_frame'   \
		         src= '" + app_url_notice + "' seamless='seamless' scrolling='no'   \
		         onload='this.height=NoticePage_frame.document.body.scrollHeight' style='height:1840px;' ></iframe>")	
	}                         
}


function loadPersonalPage() {
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='Personalinfo_frame' id='Personalinfo_frame'   \
		         src= '" + app_url_manage_profile +  "' seamless='seamless' scrolling='no'   \
		         style='height:1000px' ></iframe>");	
	}    
}


function loadPhotoPage() {
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='Photo_frame' id='Photo_frame'   \
		         src= '" + app_url_photo + "' seamless='seamless' scrolling='no'   \
		         style='height:640px' ></iframe>");	
	}
}


function loadSafePage()
{
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='Safe_frame' id='Safe_frame'   \
		         src= '" + app_url_safe + "' seamless='seamless' scrolling='no'   \
		         style='height:446px;' ></iframe>")	
	}                         
}


function checkCookies() {
	if (document.cookie.indexOf("PHPSESSID", 0) < 0) {
		alert("Session Expired! Please re-login.");
		location="../welcome page/index.html";	
		return false;
	} 
	return true
}


function loadSeekHelp()
{
	if (checkCookies()) {
		$(".info_container").append("<iframe class='iframe' name='SeekHelp_frame' id='SeekHelp_frame'   \
		         src= '" + app_url_search + "' seamless='seamless' scrolling='no'   \
		         onload='this.height=SeekHelp_frame.document.body.scrollHeight' style='height:1040px;' ></iframe>")	
	}                         
}


function icon_change($obj) {
    $("#btn_main div img").attr('src', public_url + '/img/icon/home.png');
	$("#btn_profile div img").attr('src', public_url + '/img/icon/myinfo.png');
	$("#btn_friends div img").attr('src', public_url + '/img/icon/friend.png');
	$("#btn_message div img").attr('src', public_url + '/img/icon/chat.png');
	$("#btn_search div img").attr('src', public_url + '/img/icon/find.png');
	$("#btn_posts div img").attr('src', public_url + '/img/icon/base.png');
	$("#btn_notice div img").attr('src', public_url + '/img/icon/message.png');
	$("#btn_info div img").attr('src', public_url + '/img/icon/down.png');
    $("#btn_base_info div img").attr('src', public_url + '/img/icon/basic_info.png');
    $("#btn_photo div img").attr('src', public_url + '/img/icon/photo.png');
    $("#btn_safe div img").attr('src', public_url + '/img/icon/safe.png');
    //$("#btn_comp div img").attr('src', public_url + '/img/icon/apply.png');
    
   
    
   
    switch ($obj.attr('id')) {
        case "btn_main":
            $("#btn_main div img").attr('src', public_url + '/img/icon/home_c.png');
            break;
		case "btn_profile":
            $("#btn_profile div img").attr('src', public_url + '/img/icon/myinfo.png');
            break;
		case "btn_friends":
            $("#btn_friends div img").attr('src', public_url + '/img/icon/friend.png');
            break;	
		case "btn_message":
            $("#btn_message div img").attr('src', public_url + '/img/icon/chat.png');
            break;	
		case "btn_search":
            $("#btn_search div img").attr('src', public_url + '/img/icon/find_c.png');
            break;
		case "btn_posts":
            $("#btn_posts div img").attr('src', public_url + '/img/icon/base_c.png');
            break;
		case "btn_info":
            $("#btn_info div img").attr('src', public_url + '/img/icon/down.png');
            break;
        case "btn_base_info":
            $("#btn_base_info div img").attr('src', public_url + '/img/icon/basic_info.png');
            break;
		case "btn_photo":
            $("#btn_photo div img").attr('src', public_url + '/img/icon/photo.png');
            break;
        case "btn_safe":
            $("#btn_safe div img").attr('src', public_url + '/img/icon/safe_c.png');
            break;
        
        
        
        
        

    }
}


$(document).ready(function () {	
	
    var script_load_finished = new function () {
        this.base_info = false;
        this.profile = false;
    };

    $(".navb a,.info_child a").click(function () {
    	navClick($(this));
    });

    $(".navb a,.info_child a").hover(function () {
        if ($(this).attr("class") == "clickble select") {
            $(this).css('background-color', '#3ba9de');
        }
    });

    $(".navb a,.info_child a").mouseout(function () {
        $(this).removeAttr('style');
    });
	
	//checkCookies();
	
	$.ajax(
	{           	
		url: "../load.php",
		type: "POST",
		async:false,
		success: function (return_name) {
			return_name = return_name.replace(/^\s+|\s+$/g,"");
			username = return_name.toString();
			//alert(username);
			if(username.length <6){
				//alert(username);
				session_expired();
			}
			user_name = username;
			//alert(user_name);
		}
	});
	
	var src = window.location.href; 
	var I = src.indexOf("?user=") + 6; 
	//alert(I);
	var T = src.indexOf("?user="); 
	//alert(T);
	//alert(src.length);
	//alert(src); 
	if ( (0 >= T)||(I == src.length) ){
		document.location = '/Project/user page/user.html?user='+ user_name; // illigal operation
	}
	var endofid;
	if(src.indexOf("#") <=0 ){
		endofid = src.length;
		//alert(1);
	}
	else{
		endofid = src.indexOf("#");
		//alert(2);
	}
	//alert(endofid);
	user_id = src.substr(src.indexOf("?user=") + 6, endofid-src.indexOf("?user=")-6 ); 
	//alert(user_id);
	if(user_id != user_name){
		$("#btn_info").remove();
		$("#btn_search").remove();
		$("#btn_posts").remove();
		$("#btn_notice").remove();
		$("#btn_message").remove();
	}
	$("#btn_main").trigger("click");
	location = '#main';
	if(user_id != user_name){
		document.getElementById("page_owner_id").innerHTML = user_id + "'s Home";
	}else{
		document.getElementById("page_owner_id").innerHTML = "My Home";
	}
	

});

function toMyhome(){
	location = "../user page/user.html?user="+ user_name;
}


