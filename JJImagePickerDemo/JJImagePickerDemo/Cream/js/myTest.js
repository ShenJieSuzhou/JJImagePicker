/*
 * JS 调用 OC
 * */
function myFunction(){
	sendKey();
	// alert("功能尚未开放");
}

/*
 * 解析数据加载页面
 */
function sendKey(json){
	//var json = '[{"work":"女性模特的四肢柔软地弯曲能更好的突显身体轮廓。在身体和腰部之间形成一定空隙，可以将关注点带到身形上，并通过将胸部微微前倾来凸显女性特征","path":"https://pic1.zhimg.com/80/v2-ad32d1a90216857cb0b03658d748d368_hd.png","name":"张三","iconUrl":"https://pic2.zhimg.com/80/v2-9146056b17d7726d270a1c3da8a508b5_hd.png"},{"work":"男性模特可以通过在手臂和双腿间形成锐角，来彰显男子气概。让模特双手插兜或放在臀部，同时保持肩膀和双臂的放松，看起来会更加自然。","path":"https://pic4.zhimg.com/80/v2-e7e6bcedc3b03363cb964a6b8eb1eaeb_hd.png","name":"李四","iconUrl":"https://pic2.zhimg.com/80/v2-db57906cd299d2677b9fa6fc03c8a609_hd.png"},{"work":"但是，千万不能仅限于模仿其他摄像师的照片。保存照片的首要目的是将其作为灵感，而非单纯地复制。学习别人的作品，能帮你最终形成自己的风格和拍摄方法。最后你仍然需要依靠自己的创意直觉来进行专属于你的姿势创作。","path":"https://pic1.zhimg.com/80/v2-f29b704520b4a9c002c894cdc895cfb8_hd.png","name":"王五","iconUrl":"https://pic3.zhimg.com/80/v2-8d3255320a81a38a6a7f2ac06363a056_hd.png"},{"work":"进行专属于你的姿势创作2312312312","path":"https://pic1.zhimg.com/80/v2-0ca1a32bc2578e6fb000508b882c80ec_hd.png","name":"赵六","iconUrl":"https://pic1.zhimg.com/80/v2-f29b704520b4a9c002c894cdc895cfb8_hd.png"},{"work":"同时，左右脸都要拍摄一下，看哪边效果更好。因为人脸不是完全对称的，很有可能有一边脸更加上镜。","path":"https://pic4.zhimg.com/80/v2-9521883881c49a58da0a2cc67236f25b_hd.png","name":"安东尼","iconUrl":"https://pic1.zhimg.com/80/v2-63048f686ab46d32f2fa39a6931ee034_hd.png"},{"work":"如果想营造拍摄对象直视观者的效果，就让其直视镜头。","path":"https://pic1.zhimg.com/80/v2-e8e45b9be254b3ecde369f7ee6784b2c_hd.png","name":"约翰","iconUrl":"https://pic4.zhimg.com/80/v2-e7e6bcedc3b03363cb964a6b8eb1eaeb_hd.png"},{"work":"如果笑容还是很僵硬，不妨让他们用舌头顶住上颚，","path":"https://pic2.zhimg.com/80/v2-f27f034c756e8266439a9812dd5021a9_hd.png","name":"强森","iconUrl":"https://pic1.zhimg.com/80/v2-ad32d1a90216857cb0b03658d748d368_hd.png"}]';
	var array = JSON.parse(json);
	var $div = $('#hotList');
	for(var i = 0; i < array.length; i++){
		var mMap = array[i];
		var userName = mMap["name"];
		var headImg = mMap["iconUrl"];
		var desc = mMap["work"];
		var hotImg = mMap["path"];
		
		$card = $('<div class="mui-card" id="card"></div>');
		$head = $('<div class="mui-card-header mui-card-media"></div>');
		$head.appendTo($card);

		var $headIcon = $('<img src=""/>');
		$headIcon.attr("src", headImg);
		$headIcon.appendTo($head);
		var $user = $('<div class="mui-media-body"/>');
		$user.text(userName);
		var $time = $('<p>发表于 2016-06-30 15:30</p>');
		$time.appendTo($user);
		$user.appendTo($head);

		$hotContent = $('<div class="mui-card-content"></div>');
		var $contentImg = $('<img src=""/>');
		$contentImg.attr("src",hotImg);
		$contentImg.appendTo($card);

		$foot = $('<div class="mui-card-footer"></div>');
		$foot.text(desc);
		$foot.appendTo($card);
		
		$card.appendTo($div);
	}
}
