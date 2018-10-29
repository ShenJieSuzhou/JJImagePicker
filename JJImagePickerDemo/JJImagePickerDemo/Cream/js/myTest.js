/*
 * JS 调用 OC
 * */
function myFunction(){
	
}

/*
 * 解析数据加载页面
 */
function sendKey(users){
	var array = JSON.parse(users);
	var $div = $("#hotList");
	for(var i = 0; i < array.length; i++){
		var mMap = array[i];
		var userName = mMap["name"];
		var headImg = mMap["iconUrl"];
		var desc = mMap["work"];
		var hotImg = mMap["path"];

		$('<div class="mui-card" id="card"><div class="mui-card-header mui-card-media" id="headImg"></div></div>').AppendTo($div);
		var $cardNode = $("#headImg");
		var $icon = $('<img src="images/1f3349ac37eccdf461676e7ac16ffa73.png"/>');
		$icon.attr("src",headImg);
		$icon.AppendTo($cardNode);

		var $user = $('<div class="mui-media-body" id="userName"/>');
		$user.text(userName);
		var $time = $('<p>发表于 2016-06-30 15:30</p>');
		$time.AppendTo($user);
		$user.AppendTo($cardNode);

		$hotContent = $('<div class="mui-card-content" id="hotContent"><img src=""/></div><div class="mui-card-footer" id="footer">页脚</div>');
		$hotContent.attr("src", hotImg);
		$("#footer").text(desc);
		$hotContent.AppendTo("#card");
	}
}
