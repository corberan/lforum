<#-- 
	描述：查看新帖和精华页模板
	作者：黄磊 
	版本：v1.0 
-->
<#import "inc/page_comm.ftl" as comm />
<@comm.header/>
<#if reqcfg.page_err==0>
<script type="text/javascript" src="javascript/ajax.js"></script>
<script type="text/javascript">
var templatepath = "${templatepath}";
var fid = parseInt(${forum.fid});
</script>
<script type="text/javascript" src="javascript/template_showforum.js"></script>

<div id="foruminfo">
	<div id="nav">
		<a href="${config.forumurl}">${config.forumtitle}</a> &raquo; ${forumnav}
	</div>
	<div id="forumstats">
		<p>
			<#if forumid==-1>
			<a href="main.action">全部</a>
			<a href="showtopiclist.action?type=digest&amp;forums=${forums}">精华帖区</a>
			<#else>
		        <#assign url="showforum.action?forumid="+forumid>
			<a href="${url}">全部</a>
			<a href="showtopiclist.action?forumid=${forumid}&type=digest">精华帖区</a>
			</#if>
			<#if config.rssstatus!=0>
			<a href="tools/rss.action" target="_blank"><img src="templates/${templatepath}/images/rss.gif" alt="Rss"/></a>
			</#if>
		</p>
	</div>
</div>

<#if showforumlogin==1>
	<div class="mainbox formbox">
		<h3>本版块已经被管理员设置了密码</h3>
		<form id="forumlogin" name="forumlogin" method="post" action="">
			<table cellpadding="0" cellspacing="0" border="0">
				<tbody>
				<tr>
					<th><label for="forumpassword">请输入密码</label></th>
					<td><input name="forumpassword" type="password" id="forumpassword" size="20"/></td>
				</tr>
				</tbody>
			<#if isseccode>	
				<tbody>
				<tr>
					<th><label for="vcode">输入验证码</label></th>
					<td><@comm.vcode/></td>
				</tr>
				</tbody>
			</#if>
				<tbody>
				<tr>
					<th>&nbsp;</th>
					<td>
						<input type="submit"  value="确定"/>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
<#else>

<div class="pages_btns">
	<div class="pages">
		<em>${pageid}/${pagecount}页</em>${pagenumbers}		
	</div>
</div>

<div class="mainbox threadlist">
	<h3>
		<#if (forumid>0)>
		<#assign url="showforum.action?forumid="+forum.fid>
		<a href="${url}">${forum.name}</a>
		<#elseif type=="digest">
			精华帖
		<#else>
			新帖
		</#if>
	</h3>
	<table cellpadding="0" cellspacing="0" border="0" summary="帖子">
		<thead class="category">
			<tr>
				<td class="folder">&nbsp;</td>
				<td class="icon">&nbsp;</td>
				<th>标题</th>
				<td class="author">作者</td>
				<td class="nums">回复/查看</td>
				<td class="lastpost">最后发表</td>
			</tr>
		</thead>
	<!--announcement area start-->
	<#list announcementlist as announcement>
		<tbody>
		<tr>
			<td style="line-height:28px;"><img src="templates/${templatepath}/images/announcement.gif" alt="announcement"/></td>
			<td>&nbsp;</td>
			<th><a href="announcement.action#${announcement.id}">${announcement.title}</a></th>
			<td colspan="3">
				<#if announcement.users.uid==-1>
					游客
				<#else>
					<#assign url="userinfo.action?userid="+announcement.users.uid>
					<a href="${url}">${announcement.poster}</a>
				</#if>
			</td>
		</tr>
		</tbody>
	</#list>
	<!--announcement area end-->
	<!--showtopiclist start-->
	<#list topiclist as topic>
		<tbody id="normalthread_${topic.tid}" >
		<tr>
			<td class="folder">
			<#if topic.folder!="">
				<#assign url="showtopic.action?topicid="+topic.tid>
				<a href="${url}" target="_blank"><img src="templates/${templatepath}/images/folder_${topic.folder}.gif" alt="主题图标"/></a>
			<#else>
				&nbsp;
			</#if>
			</td>
			<td class="icon">
			<#if topic.iconid!=0>
					<img src="images/posticons/${topic.iconid}.gif" alt="示图"/>
				<#else>
					&nbsp;
				</#if>
			</td>
			<th class="common">	
				<label>
				<#if (topic.digest>0)>
					<img src="templates/${templatepath}/images/digest${topic.digest}.gif" alt="digtest"/>
				</#if>
				<#if topic.special==1>
					<img src="templates/${templatepath}/images/pollsmall.gif" alt="投票" />
				</#if>
				<#if topic.special==2 || topic.special==3>
					<img src="templates/${templatepath}/images/bonus.gif" alt="悬赏"/>
				</#if>
				<#if topic.special==4>
					<img src="templates/${templatepath}/images/debatesmall.gif" alt="辩论"/>
				</#if>
				<#if (topic.attachment>0)>
					<img src="templates/${templatepath}/images/attachment.gif" alt="附件"/>
				</#if>
				</label>
				<span>
				<#if (topic.replies>0)>
					<img src="templates/${templatepath}/images/topItem_exp.gif" id="imgButton_${topic.tid}" onclick="showtree(${topic.tid},${config.ppp});" class="cursor" alt="展开帖子列表" title="展开帖子列表" />
				<#else>
					<img src="templates/${templatepath}/images/no-sublist.gif" id="imgButton_${topic.tid}"/>
				</#if>
				<#assign url="showtopic.action?topicid="+topic.tid>
				<a href="${url}">${topic.title}</a>
				<#if (topic.replies/config.ppp>0)>
					<script type="text/javascript">getpagenumbers("", ${topic.replies},${config.ppp},0,"",${topic.tid},"","");</script>
				</#if>
				</span>
			</th>
			<td class="author">
				<cite>
				<#if topic.usersByPosterid.uid==-1>
					游客
				<#else>
					<#assign url="userinfo.action?userid="+topic.usersByPosterid.uid>
					<a href="${url}">${topic.poster}</a>
				</#if></cite>
				<em>${topic.postdatetime}</em>
			</td>
			<td class="nums"><em>${topic.replies}</em> / ${topic.views}</td>
			<td class="lastpost">
					<em><a href="showtopic.action?topicid=${topic.tid}&page=end#lastpost">${topic.lastpost}</a></em>
					<cite>by
					<#if topic.usersByLastposterid.uid==-1>
						游客
					<#else>
						<a href="userinfo.action?userid=${topic.usersByLastposterid.uid}" target="_blank">${topic.lastposter}</a>
					</#if>
					</cite>
			</td>
		</tr>
		</tbody>
		<tbody>
		<tr>
			<td colspan="6" style="border:none; padding:0;"><div id="divTopic${topic.tid}"></div></td>
		</tr>
		</tbody>
	</#list>
	<!--showtopiclist end-->
	</table>
</div>
<div class="pages_btns">
	<div class="pages">
		<em>${pageid}/${pagecount}页</em>${pagenumbers}		
	</div>
</div>
<script type="text/javascript">
function CheckAll(form)
{
	for (var i = 0; i < form.elements.length; i++)
	{
		var e = form.elements[i];
		if (e.id == "fidlist"){
		   e.checked = form.chkall.checked;
		}
	}
}

function SH_SelectOne(obj)
{
	for (var i = 0; i < document.getElementById("LookBySearch").elements.length; i++)
	{
		var e = document.getElementById("LookBySearch").elements[i];
		if (e.id == "fidlist"){
		   if (!e.checked){
			document.getElementById("chkall").checked = false;
			return;
		   }
		}
	}
	document.getElementById("chkall").checked = true;

}

function ShowDetailGrid(tid)
{
  window.location.href = "showforum.action?forumid=" + tid ;
}
</script>
<#if forumid==-1>
<form name="LookBySearch" method="post" action="showtopiclist.action?search=1&forumid=${forumid}&type=${type}&newtopic=${newtopic}&forums=${forums}" ID="LookBySearch">
<div class="box" style="padding-bottom:0;">
	<h4>以下论坛版块:</h4>
	<table width="100%" border="0" cellspacing="3" cellpadding="0">
		<tr>
			 ${forumcheckboxlist}
		</tr>
	</table>
	<div style="padding:6px 0; border:none; border-top:1px solid #CCC; background:#EEE;">
		<span style="float:right;">
			排序方式
			<select name="order" id="order">
			  <option value="1" <#if order==1>selected</#if>>最后回复时间</option>
			  <option value="2" <#if order==2>selected</#if>>发布时间</option>
			</select>	
			<select name="direct" id="direct">
			  <option value="0" <#if direct==0>selected</#if>>按升序排列</option>
			  <option value="1" <#if direct==1>selected</#if>>按降序排列</option>
			</select>
			<button type="submit" onclick="document.LookBySearch.submit();">提交</button>
		</span>
		<input title="选中/取消选中 本页所有Case" onclick="CheckAll(this.form)" type="checkbox" name="chkall" id="chkall">全选/取消全选
	</div>
</div>
</form>

<div id="footfilter" class="box">
	<#if config.forumjump==1>
    <select onchange="if(this.options[this.selectedIndex].value != '') { jumpurl(this.options[this.selectedIndex].value);}">
		<option>论坛跳转...</option>
		${forumlistboxoptions}
	</select>
	</#if>
	<#if (config.visitedforums>0)>
    <select name="select2" onchange="if(this.options[this.selectedIndex].value != '') {jumpurl(this.options[this.selectedIndex].value);}">
		<option>最近访问...</option>${visitedforumsoptions}
	</select>
	</#if>
	<script type="text/javascript">	
	function jumpurl(fid) {		
		window.location='showforum.action?forumid=' + fid ;
	}
	</script>
</div>
</#if>

</#if>
</div>
<#else>
<@comm.errmsgbox/>
</div>
</#if>
<@comm.copyright/>
<@comm.footer/>