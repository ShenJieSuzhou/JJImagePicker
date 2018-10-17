/*
 * JS 调用 OC
 * */
function myFunction(){
	var txt = "123";
	var x = 1;
//	window.webkit.messageHandlers.collectSendKey.postMessage(txt);
	sendKey(txt);
}

function sendKey(user_id){
   var content = document.getElementById("my_title");
   content.innerHTML = user_id;
}
