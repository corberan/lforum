﻿<#-- 
	描述：帖子评分记录模板
	作者：黄磊 
	版本：v1.0 
-->	
<script type="text/javascript">
function ratevalveimg(rate,ratevalveset)
{
    valveimg = '';
	if(rate) {
		image = rate > 0 ? 'templates/${templatepath}/images/agree.gif' : 'templates/${templatepath}/images/disagree.gif';
		var  ratevalve = ratevalveset.split(",");
		for(i = 0; i < ratevalve.length; i++) {
		    if(Math.abs(rate)>ratevalve[i]){ 
			    valveimg += '<img src="' + image + '" border="0" alt="" />';
			}
			else{
			    break;
			}
		}
	}
	return valveimg;
}
</script>
	<div class="ratelog">
		<#if showratelog==1>
		<div id="rate_${post.pid}_fake"><script type="text/javascript">document.write(ratevalveimg(${post.rate},'${config.ratevalveset}'));</script> <a href="###" title="查看/收起 评分记录" onclick="showrate(${post.pid},0)">本帖被评分 ${post.ratetimes} 次</a></div>
		<div id="rate_${post.pid}_real" style="display:none">
		<fieldset style="width: 600px;">
			<legend><script>document.write(ratevalveimg(${post.rate},'${config.ratevalveset}'));</script> <a href="###" title="查看/收起 评分记录" onclick="showrate(${post.pid},0)">本帖被评分 ${post.ratetimes} 次</a> </legend>
			<div id="rate_${post.pid}" style="margin: 5px; height: 77px; overflow: auto;"></div>
		</fieldset>
		</div>
	<script type="text/javascript">_attachEvent(window, "load", function(){ showrate(${post.pid},0); })</script>
		<#else>
	<script type="text/javascript">document.write(ratevalveimg(${post.rate},'${config.ratevalveset}'));</script>本帖被评分 ${post.ratetimes} 次
		</#if>
	</div>
