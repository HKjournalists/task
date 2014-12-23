$(document).ready(function(){
   // 内容区域高度自适应
	   reHeightMainIframe();
});

function reHeightMainIframe(){
var content_height;
var content_width;
// 高度调整
//var winHeight = document.documentElement.clientHeight; // 取document高度
//var winWidth = document.documentElement.clientWidth; // 取document宽度
var winHeight = document.body.clientHeight; // for quirks mode
var winWidth = document.body.clientWidth; // for quirks mode
content_height = (parseInt(winHeight)-75)+"px"; // 调整到合适的高度
content_width = (parseInt(winWidth)-12)+"px"; // 调整到合适的宽度
$("#mainFrame").height(content_height);
$("#mainFrame").width(content_width);
window.onresize = reHeightMainIframe;
}