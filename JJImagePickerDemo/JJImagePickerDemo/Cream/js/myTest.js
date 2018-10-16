/*
 * JS 调用 OC
 * */
function myFunction(){
	var txt = "123";
	var x = 1;
	window.webkit.messageHandlers.collectSendKey.postMessage(txt);
}

function sendKey(user_id){
    $("#input").val(user_id);
}
