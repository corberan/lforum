<#-- 
	描述：发表回复模板
	作者：黄磊 
	版本：v1.0 
-->
<#import "inc/page_comm.ftl" as comm />
<@comm.header/>
<script language="javascript" type="text/javascript" src="javascript/template_calendar.js"></script>
<script type="text/javascript">
var postminchars = parseInt('${config.minpostsize.toString()}');
var postmaxchars = parseInt('${config.maxpostsize.toString()}');
var disablepostctrl = parseInt('${disablepost.toString()}');
var forumpath = "";
</script>
<div id="foruminfo">
	<div id="nav">
		<a href="${config.forumurl}" class="home">${config.forumtitle}</a> &raquo; ${forumnav}  &raquo; 
		<a href="showtopic.action?topicid=${topicid}">${topictitle}</a>  &raquo; 回复主题
	</div>
</div>
<#if reqcfg.page_err==0>
<#if ispost>
<@comm.msgbox/>
<#else>
	<div class="mainbox viewthread" id="previewtable" style="display: none">
		<h1>预览帖子</h1>
		<table summary="预览帖子" cellspacing="0" cellpadding="0">
		<tr>
				<td class="postauthor">${username}</td>
				<td class="postcontent">
			<span class="fontfamily">${nowdatetime}</span>
			<span id="previewmessage"></span>
		</td>
		</tr>
		</table> 
	</div>
	<form method="post" name="postform" id="postform" action="" enctype="multipart/form-data" onsubmit="return validate(this);">
	<div class="mainbox formbox">
		<h1>回复主题</h1>
		<table summary="post" cellspacing="0" cellpadding="0" id="newpost">
		<@comm.tempaccounts/>	
		<tbody>
		<tr>
			<th><label for="title">标题</label></th>
			<td>
			<#if topic.special==4>
			<select id="debateopinion" name="debateopinion">
			<option selected="" value="0"/>
			<option value="1">正方</option>
			<option value="2">反方</option>
			</select>
			</#if>
			<input name="title" id="title" type="text" value="" size="60" title="标题最多为60个字符" /><em class="tips">(可选)</em>
			</td>
		</tr>
		</tbody>
		<tbody>
		<tr>
			<@comm.editor/>
		</tr>	      
		</tbody> 
		<#if isseccode>
		<tbody>
		<tr>
			<th><label for="vcode">验证码</label></th>
			<td>
			<@comm.vcode/>
			</td>
		</tr>
		</tbody>
		</#if>
		<tbody>
			<tr>
			<th>&nbsp;</th>
			<td>
				<input name="replysubmit" type="submit" id="postsubmit" value="发表回复"/>	
				<input name="continuereply" type="checkbox" <#if continuereply!="">checked</#if> /> 连续回复	[完成后可按 Ctrl + Enter 发布]
			</td>
		</tr>
		</tbody>
		</table>
		<p class="textmsg" id="divshowuploadmsg" style="display:none"></p>
		<p class="textmsg succ" id="divshowuploadmsgok" style="display:none"></p>
		<input type="hidden" name="uploadallowmax" value="10">
		<input type="hidden" name="uploadallowtype" value="jpg,gif">
		<input type="hidden" name="thumbwidth" value="300">
		<input type="hidden" name="thumbheight" value="250">
		<input type="hidden" name="noinsert" value="0">
	</div>
	</form>
	<script type="text/javascript">
		if (getQueryString('restore') == 1)
		{
			loadData(true);
		}
	</script>
	<div class="mainbox">
		<h3>最后5帖</h3>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tbody>
				<#list lastpostlist as lastpost>
				<tr>
					<td width="15%" align="left" style="padding-left:2px;">来自: <a href="showuser.action?userid=${lastpost.users.uid}">${lastpost.poster}</a></td> 	
					<td width="25%">回复日期:${lastpost.postdatetime}</td>
					<td width="60%" align="left">内容:${lastpost.message}</td>	
				</tr>
				</#list>
			</tbody>
		</table>
	</div>
</div>
</#if>
<#else>
	<#if needlogin>
		<@comm.login/>
	<#else>
		<@comm.errmsgbox/>
	</#if>
</div>
</#if>
<@comm.copyright/>
<@comm.footer/>