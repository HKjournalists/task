$(document).ready(function(){
   // ��������߶�����Ӧ
	   reHeightMainIframe();
});

function reHeightMainIframe(){
var content_height;
var content_width;
// �߶ȵ���
//var winHeight = document.documentElement.clientHeight; // ȡdocument�߶�
//var winWidth = document.documentElement.clientWidth; // ȡdocument���
var winHeight = document.body.clientHeight; // for quirks mode
var winWidth = document.body.clientWidth; // for quirks mode
content_height = (parseInt(winHeight)-75)+"px"; // ���������ʵĸ߶�
content_width = (parseInt(winWidth)-12)+"px"; // ���������ʵĿ��
$("#mainFrame").height(content_height);
$("#mainFrame").width(content_width);
window.onresize = reHeightMainIframe;
}