<#-- 
	描述：帖子树形显示页模板
	作者：黄磊 
	版本：v1.0 
-->
<#import "inc/page_comm.ftl" as comm />
<@comm.header/>
<#assign loopi=1>
<#if reqcfg.page_err==0>
<#if enabletag>
<script type="text/javascript" src="cache/tag/closedtags.txt"></script>
<script type="text/javascript" src="cache/tag/colorfultags.txt"></script>
</#if>
<script type="text/javascript" src="javascript/ajax.js"></script>
<script type="text/javascript" src="javascript/template_showtopic.js"></script>
<script type="text/javascript">
var templatepath = "${templatepath}";
var postminchars = parseInt(${config.minpostsize});
var postmaxchars = parseInt(${config.maxpostsize});
var disablepostctrl = parseInt(${disablepostctrl});
var forumpath = "";
</script>
<div id="foruminfo">
	<div id="nav">
		<a href="${config.forumurl}">${config.forumtitle}</a> &raquo; ${forumnav} &raquo; 
		<#assign ishtmltitle = topicManager.getMagicValue(topic.magic, 1)>
		<#if ishtmltitle==1>
			<strong>${topicManager.getHtmlTitle(topic.tid)}</strong>
		<#else>
			<strong>${topictitle}</strong>
		</#if>
	</div>
	<div id="headsearch">
		<div id="search">
		<#if (usergroupinfo.allowsearch>0)>
			<@comm.quicksearch/>
		</#if>
		</div>
	</div>
</div>
<@comm.pagewordadlist/>
<@comm.newpmmsgbox/>
<@comm.poll/>
<div class="pages_btns">
	<span class="postbtn">	
	<#if (userid<0||canposttopic)>
	    <span onmouseover="$('newspecial').id = 'newspecialtmp';this.id = 'newspecial';if($('newspecial_menu').childNodes.length>0)  showMenu(this.id);" id="newspecial" class="postbtn"><a title="发新话题" id="newtopic" href="posttopic.action?forumid=${forum.fid}" onmouseover="if($('newspecial_menu').childNodes.length>0)  showMenu(this.id);"><img alt="发新话题" src="templates/${templatepath}/images/newtopic.gif"/></a></span>
    </#if>   
	<#if canreply>
	    <SPAN class="replybtn"><a href="postreply.action?topicid=${topicid}"><img src="templates/${templatepath}/images/reply.gif" border="0" alt="回复该主题" /></a></span>
    </#if>
	
	</span>
</div>
<div class="mainbox viewthread">
	<h3>
		<#if forum.forumfields.applytopictype==1 && forum.forumfields.topictypeprefix==1>
			${topictypes} 
		</#if>
			${topictitle}
		<#if (topic.price>0 && topic.usersByPosterid.uid!=userid)>
			<a href="buytopic.action?topicid=${topicid}&showpayments=1">浏览需支付 ${userextcreditsinfo.name} ${topic.price} ${userextcreditsinfo.unit}</a>
		</#if>
	</h3>
	<table cellpadding="0" cellspacing="0" border="0">
		<tbody>
		<tr>
		<td class="postauthor" id="{post.pid}">
		<!--register user-->
		<#if post.posterid!=-1>
			<cite>
				<a href="#" target="_blank" id="memberinfo_${loopi}" class="dropmenu" onmouseover="showMenu(this.id)">
			<#if post.onlinestate==1>					
				<img src="templates/${templatepath}/images/useronline.gif" alt="在线" title="在线"/>
			<#else>
				<img src="templates/${templatepath}/images/useroutline.gif"  alt="离线" title="离线"/>
			</#if>
				${post.poster}
				</a>
			</cite>
			<#if config.showavatars==1 && post.avatar!="">
			<div class="avatar">
				<img class="avatar" src="${post.avatar}" onerror="this.onerror=null;this.src='templates/${templatepath}/images/noavatar.gif';" 
						<#if (post.avatarwidth>0)>
							width="${post.avatarwidth}"
							height="${post.avatarheight}"
						</#if> alt="头像"
					/>	
			</div>		
			</#if>
			<#if post.nickname!="">
			<p><em>${post.nickname}</em></p>
			</#if>
			<p>
			<script language="javascript" type="text/javascript">
				ShowStars(${post.stars}, ${config.starthreshold});
			</script>
			</p>
			<ul class="otherinfo">
			<#if config.userstatusby==1>
				<li>组别:${post.status}</li>
			</#if>
				<li>性别:<script type="text/javascript">document.write(displayGender(${post.gender}));</script></li>
			<#if post.bday!="">
				<li>生日:${post.bday}</li>
			</#if>
				<li>来自:${post.location}</li>
				<li>积分:${post.credits}</li>
				<li>帖子:${post.posts}</li>
				<li>注册:<#if post.joindate!="">${post.joindate}</#if></li>
				</ul>
			</div>
			<#if post.medals!="">
			<div class="medals">${post.medals}</div>
			</#if>
			<#else>
				<div class="ipshow"><strong>${post.poster}</strong>  {post.ip}
				<#if (useradminid>0 && admininfo.allowviewip==1)>
					<a href="getip.action?pid=${post.pid}&topicid=${topicid}" title="查看IP"><img src="templates/${templatepath}/images/ip.gif" alt="查看IP" /></a>
				</#if>
				</div>
			<!--guest-->
				<div class="noregediter">
					未注册
				</div>
		</#if>	
		</td>
		<td class="postcontent">
			<div class="postinfo">
				<em>${post.postdatetime}</em>
				<a href="showtopic.action?topicid=${topicid}">平板</a>|
				<a href="favorites.action?topicid=${topicid}">收藏</a>|
				<#if ismoder==1>
					<a href="editpost.action?topicid=${topicid}&postid=${post.pid}">编辑</a>|
					<a href="delpost.action?topicid=${topicid}&postid=${post.pid}" onclick="return confirm('确定要删除吗?');">删除</a>|
					<#if post.posterid!=-1>
						<a href="###" onclick="action_onchange('rate',$('moderate'),'${post.pid}');">评分</a>|
						<#if (post.ratetimes>0)>
						<a href="###" onclick="action_onchange('cancelrate',$('moderate'),'${post.pid}');">撤销评分</a>&nbsp;
						</#if>
						<#if post.invisible==-2>
					<a href="###" onclick="action_onchange('banpost',$('moderate'),'${post.pid}','0');">撤销屏蔽</a>|
				<#else>
					<a href="###" onclick="action_onchange('banpost',$('moderate'),'${post.pid}','-2');">屏蔽帖子</a>|
				</#if>
					</#if>
					<input name="postid" id="postid" value="${post.pid}" type="checkbox" />
				<#else>
					<#if post.posterid!=-1 && userid==post.posterid>
						<#if topic.closed==0>
							<a href="editpost.action?topicid=${topicid}&postid=${post.pid}">编辑</a>|
						</#if>
						<a href="delpost.action?topicid=${topicid}&postid=${post.pid}" onclick="return confirm('确定要删除吗?');">删除</a>|
					</#if>
					<#if usergroupinfo.raterange!="" && post.posterid!=-1><a href="###" onclick="action_onchange('rate',$('moderate'),'${post.pid}');">评分</a>
					</#if>
				</#if>
				<a href="###" class="t_number" onclick="$('message${post.pid}').className='t_smallfont'">小</a>			
				<a href="###" class="t_number" onclick="$('message${post.pid}').className='t_msgfont'">中</a>
				<a href="###" class="t_number" onclick="$('message${post.pid}').className='t_bigfont'">大</a>
			</div>
			<div id="ad_thread2_1"></div>
			<div class="postmessage defaultpost">
			<#if post.invisible!=-2 || ismoder==1>
				<#if (topic.identify>0)>
				<div class="ntprint" onclick="this.style.display='none';"><img onload="setIdentify(this.parentNode);" src="images/identify/${topicidentify.filename}" alt="点击关闭鉴定图章" title="点击关闭鉴定图章" /></div>
				</#if>
				<#if ismoder==1 && post.invisible==-2>
						<!--管理组有权查看内容开始-->
						<div class='hintinfo'>提示: 该帖已被屏蔽, 您拥有管理权限, 以下是帖子内容</div>		              
					</#if>
				<h2>${post.title}</h2>
				<div id="message${post.pid}" class="t_msgfont">
					<div id="ad_thread3_1"></div>
					<#if post.layer==0 && enabletag>
						<div id="firstpost">
					</#if>
							${post.message}
					<#if post.layer==0 && enabletag>
						</div>
					</#if>
				</div>

				<#if (attachmentlist?size>0)>
					<#assign currentattachcount = 0>
					<#list attachmentlist as attachtemp>
						<#if attachtemp.postid.pid==post.pid>
							<#assign currentattachcount = currentattachcount + 1>
						</#if>
					</#list>
					<#if  (currentattachcount>0)>
						<#assign getattachperm = attachmentlist.get(0).getattachperm>
						<#if getattachperm==1>
					<div class="box postattachlist">
						<h4>附件</h4>
					<#list attachmentlist as attachment>
						<#if attachment.postid.pid==post.pid>
							<!--附件开始-->
								<#if attachment.allowread==1>
								<#include "inc/commfiles/_attachmentinfo.ftl">
								<#else>
								<span class="notdown">你的下载权限 ${usergroupinfo.readaccess} 低于此附件所需权限 ${attachment.readperm}, 你无权查看此附件</span>
								</#if>
							<!--附件结束-->
						</#if>
					</#list>
					</div>
						<#else>
					<div class="notice" style="width: 500px;">
					附件:<em>您所在的用户组无法下载或查看附件</em>
					</div>
						</#if>
					</#if>
				</#if>
				
			<#if (post.ratetimes>0)>
				<@comm.ratelog/>
			</#if>
			<#if post.lastedit!="">
				<!--最后编辑开始-->
				<div class="lastediter">
					<img src="templates/${templatepath}/images/lastedit.gif" alt="最后编辑"/>${post.lastedit}
				</div>
				<!--最后编辑结束-->
			</#if>
			<#if post.id==1>
					<#if topic.special==3>
						<div class="quote">
							<div class="text"><p>本帖得分:</p>
								<div class="attachmentinfo">
									<#list bonuslogs as bonuslog>
										<#assign unit = scoreunit[bonuslog.extid]>
										<#assign name = score[bonuslog.extid]>
										<a href="userinfo.action?userid=${bonuslog.usersByAnswerid.uid}">${bonuslog.answername}</a>(${bonuslog.bonus} ${unit}${name})
										<#if bonuslog__index!=bonuslogs?size>
											,
										</#if>
									</#list>					
								</div>
							</div>
						</div>
					</#if>
			</#if>
			<#if forum.allowtag==1 && post.layer==0>
				<script type="text/javascript">
					function forumhottag_callback(data)
					{
						tags = data;
					}
				</script>
				<script type="text/javascript" src="cache/hottags_forum_cache_jsonp.txt"></script>
				<div id="topictag">
					<#assign hastag = topicManager.getMagicValue(topic.magic, 3)>
					<#if hastag==1>
						<script type="text/javascript">getTopicTags(${topic.tid});</script>
					<#else>
						<script type="text/javascript">parsetag();</script>
					</#if>
				</div>
			</#if>
		    
			</div>
			<#else>
			<div id="message${post.pid}" class="t_msgfont">
					
			          <div class='hintinfo'>提示: 该帖被管理员或版主屏蔽</div>
			</div>
			</#if>	
			<#if config.showsignatures==1>
			<#if post.usesig==1>
				<#if post.signature!="">
			<!--签名开始-->
				<div class="postertext">
					<#if (config.maxsigrows>0)>
						<#assign ieheight=config.maxsigrows*12>
						<div class="signatures" style="max-height: ${config.maxsigrows}em;maxHeightIE:${ieheight}px">${post.signature}</div>
					<#else>
						${post.signature}
					</#if>
				</div>
			<!--签名结束-->
				</#if>
			</#if>
		</#if>
	</td>
	</tr>
	</tbody>
	<tbody>
	<tr>
	<!--用户信息结束-->
		<td class="postauthor">&nbsp;</td>
		<td class="postcontent">
			<div class="postactions">
				<p>
				<#if userid!=-1>
				<@comm.report/>|
				</#if>
				<#if canreply>
					<a href="postreply.action?topicid=${topicid}&postid=${post.pid}&quote=yes">引用</a>|
					<#if userid!=-1>
					<a href="###" onclick="replyToFloor('${post.id}', '${post.poster}', '${post.pid}')">回复</a>|
					</#if>
				</#if>
					<a href="###" onclick="window.scrollTo(0,0)">TOP</a>
				</p>
				<div id="ad_thread1_1"></div>
			</div>
		</td>
	</tr>
	</tbody>
</table>
</div>
<#if post.posterid!=-1>
<!-- member menu -->
<div class="popupmenu_popup userinfopanel" id="memberinfo_${loopi}_menu" style="display: none; z-index: 50; filter: progid:dximagetransform.microsoft.shadow(direction=135,color=#cccccc,strength=2); left: 19px; clip: rect(auto auto auto auto); position absolute; top: 253px; width:150px;" initialized ctrlkey="userinfo2" h="209">
	<p class="recivemessage"><a href="usercppostpm.action?msgtoid=${post.posterid}" target="_blank">发送短消息</a></p>
	<#if (useradminid>0)>
		<#if admininfo.allowviewip==1>
			<p  class="seeip"><a href="getip.action?pid=${post.pid}&topicid=${topicid}" title="查看IP">查看IP</a></p>
		</#if>
		<#if admininfo.allowbanuser==1>
			<p><a href="useradmin.action?action=banuser&uid=${post.posterid}" title="禁止用户">禁止用户</a></p>
		</#if>
	</#if>
	<p>
		<a href="userinfo.action?userid=${topic.usersByPosterid.uid}" target="_blank">查看公共资料</a></p>
	<p><a href="search.action?posterid=${post.posterid}">查找该会员全部帖子</a></p>
	<ul>
		<li>UID:${post.posterid}</li>
		<li>精华:<#if (post.digestposts>0)><a href="search.action?posterid=${post.posterid}&type=digest">${post.digestposts}</a><#else>${post.digestposts}</#if></li>
		<#if score[1]!="">
			<li>${score[1]}:${post.extcredits1} ${scoreunit[1]}</li>
		</#if>
		<#if score[2]!="">
			<li>${score[2]}:${post.extcredits2} ${scoreunit[2]}</li>
		</#if>
		<#if score[3]!="">
			<li>${score[3]}:${post.extcredits3} ${scoreunit[3]}</li>
		</#if>
		<#if score[4]!="">
			<li>${score[4]}:${post.extcredits4} ${scoreunit[4]}</li>
		</#if>
		<#if score[5]!="">
			<li>${score[5]}:${post.extcredits5} ${scoreunit[5]}</li>
		</#if>
		<#if score[6]!="">
			<li>${score[6]}:${post.extcredits6} ${scoreunit[6]}</li>
		</#if>
		<#if score[7]!="">
			<li>${score[7]}:${post.extcredits7} ${scoreunit[7]}</li>
		</#if>
		<#if score[8]!="">
			<li>${score[8]}:${post.extcredits8} ${scoreunit[8]}</li>
		</#if>
			<li>来自:${post.location}</li>
			<li>注册:<#if post.joindate!="">${post.joindate}</#if></li>	
	</ul>
	<p>状态:<span><#if post.onlinestate==1>
		在线
		<#else>
		离线
		</#if></span>
	</p>
	<ul class="tools">
		<#if post.msn!="">
		<li>
			<img src="templates/${templatepath}/images/msnchat.gif" alt="MSN Messenger: ${post.msn}"/>
			<a href="mailto:${post.msn}" target="_blank">${post.msn}</a>
		</li>
		</#if>
		<#if post.skype!="">
		<li>
			<img src="templates/${templatepath}/images/skype.gif" alt="Skype: ${post.skype}"/>
			<a href="skype:${post.skype}" target="_blank">${post.skype}</a>
		</li>
		</#if>
		<#if post.icq!="">
		<li>
			<img src="templates/${templatepath}/images/icq.gif" alt="ICQ: ${post.icq}" />
			<a href="http://wwp.icq.com/scripts/search.dll?to=${post.icq}" target="_blank">${post.icq}</a>
		</li>
		</#if>
		<#if post.qq!="">
		<li>
			<img src="templates/${templatepath}/images/qq.gif" alt="QQ: ${post.qq}"/>
			<a href="http://wpa.qq.com/msgrd?V=1&Uin=${post.qq}&Site=${config.forumtitle}&Menu=yes" target="_blank">${post.qq}</a>
		</li>
		</#if>
		<#if post.yahoo!="">
		<li>
			<img src="templates/${templatepath}/images/yahoo.gif" width="16" alt="Yahoo Messenger: ${post.yahoo}"/>
			<a href="http://edit.yahoo.com/config/send_webmesg?.target=${post.yahoo}&.src=pg" target="_blank">${post.yahoo}</a>
		</li>
		</#if>
	</ul>
</div>
<!-- member menu -->
</#if>
<!--ntforumbox end-->
<div class="pages_btns">
	<span class="postbtn">	
	<#if (userid<0)||canposttopic>
	    <span onmouseover="$('newspecial').id = 'newspecialtmp';this.id = 'newspecial';if($('newspecial_menu').childNodes.length>0)  showMenu(this.id);" id="Span1" class="postbtn"><a title="发新话题" id="A1" href="posttopic.action?forumid=${forum.fid}" onmouseover="if($('newspecial_menu').childNodes.length>0)  showMenu(this.id);"><img alt="发新话题" src="templates/${templatepath}/images/newtopic.gif"/></a></span>
    </#if>   
	<#if canreply>
	    <SPAN class="replybtn"><a href="postreply.action?topicid=${topicid}"><img src="templates/${templatepath}/images/reply.gif" border="0" alt="回复该主题" /></a></span>
    </#if>
	</span>
</div>
<#if canreply>
<!--quickreply-->
	<#assign isenddebate=true>
	<#include "inc/commfiles/_quickreply.ftl">
<!--quickreply-->
</#if>
<!--replay-->


<#if userid<0||canposttopic>
	<ul class="popupmenu_popup newspecialmenu" id="newspecial_menu" style="display: none">
	 <#if forum.allowspecialonly<=0>
		<li><a href="posttopic.action?forumid=${forum.fid}">发新主题</a></li>
		</#if>
		<#assign specialpost = reqcfg.opNum(forum.allowpostspecial,1) >
		<#if specialpost==1 && usergroupinfo.allowpostpoll==1>
		<li class="poll"><a href="posttopic.action?forumid=${forum.fid}&type=poll">发布投票</a></li>
		</#if>
		<#assign specialpost = reqcfg.opNum(forum.allowpostspecial,4) >
		<#if specialpost==4 && usergroupinfo.allowbonus==1>
			<li class="reward"><a href="posttopic.action?forumid=${forum.fid}&type=bonus">发布悬赏</a></li>
		</#if>
		<#assign specialpost = reqcfg.opNum(forum.allowpostspecial,16) >
		<#if specialpost==16 && usergroupinfo.allowdebate==1>
			<li class="debate"><a href="posttopic.action?forumid=${forum.fid}&type=debate">发起辩论</a></li>
		</#if>
	</ul>
</#if>

<div class="mainbox">
	<h3>标题: ${topictitle}</h3>
	<table cellpadding="0" cellspacing="0" border="0">
	<#list posttree as posttreeitem>
	<tr>
		<td>
		·<a href="showtree.action?topicid=${topicid}&postid=${posttreeitem[0]}">
		<#if posttreeitem[0]==postid>
			${posttreeitem[2]}
		<#else>
			${posttreeitem[2]}
		</#if>
		</a>
		</td>
		<td>
		<#if posttreeitem[4]==-1>
			游客
		<#else>
			<a href="userinfo.action?userid=${posttreeitem[4]}">${posttreeitem[3]}</a>
		</#if>
		</td>
		<td>发表于 ${posttreeitem[5]}</td>
	</tr>
	</#list>
	</table>
</div>
<!--reply-->
<#if (useradminid>0)||usergroupinfo.raterange!=""||config.forumjump==1>
<!--forumjumping start-->
<div id="footfilter" class="box">
	<#if (useradminid>0)>
		<script type="text/javascript">
			function action_onchange(value,objfrm,postid){
				if (value != ''){
					objfrm.operat.value = value;
					objfrm.postid.value = postid;
					if(value != 'delpost'){
						objfrm.submit();
					}
					else{
						$('delpost').submit();
					}
				}
			}
		</script>
		<form id="moderate" name="moderate" method="post" action="topicadmin.action?action=moderate&forumid=${forumid}">
			<input name="forumid" type="hidden" value="${forumid}" />
			<input name="topicid" type="hidden" value="${topicid}" />
			<input name="postid" type="hidden" value="" />
			<input name="operat" type="hidden" value="" />
			<select id="operatSel" onchange="action_onchange(this.options[this.selectedIndex].value,this.form,0);" name="operatSel">
				<option value="" selected="selected">管理选项</option>
				<option value="delete">删除主题</option>
				<option value="banpost">屏蔽单贴</option>
				<option value="delpost">批量删帖</option>
				<option value="close">关闭主题</option>
				<option value="move">移动主题</option>
				<option value="copy">复制主题</option>
				<option value="highlight">高亮显示</option>
				<option value="digest">设置精华</option>
				<option value="identify">鉴定主题</option>
				<option value="displayorder">主题置顶</option>
				<option value="split">分割主题</option>
				<option value="merge">合并主题</option>
				<option value="repair">修复主题</option>
			</select>		
		</form>
	<#elseif usergroupinfo.raterange!="">
		<script type="text/javascript">
			function action_onchange(value,objfrm,postid){
				if (value != ''){
					objfrm.operat.value = value;
					objfrm.postid.value = postid;
					if(value != 'delpost'){
						objfrm.submit();
					}
					else{
						$('delpost').submit();
					}
				}
			}
		</script>
		<form id="moderate" name="moderate" method="post" action="topicadmin.action?action=moderate&forumid=${forumid}">
			<input name="forumid" type="hidden" value="${forumid}" />
			<input name="topicid" type="hidden" value="${topicid}" />
			<input name="postid" type="hidden" value="" />
			<input name="operat" type="hidden" value="" />
		</form>
	</#if>
</div>
<!--forumjumping end-->
</#if>
</div>
<#else>
	<#if needlogin>
		<@comm.login/>
	<#else>
		<@comm.errmsgbox/>
	</#if>
</#if>
${inpostad}
<@comm.copyright/>
<@comm.adlist/>
<@comm.footer/>
