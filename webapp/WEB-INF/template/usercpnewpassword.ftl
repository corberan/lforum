<#-- 
	描述：用户中心密码修改模板
	作者：黄磊 
	版本：v1.0 
-->
<#import "inc/page_comm.ftl" as comm />
<@comm.header/>
<!--header end-->

<div id="foruminfo">
	<div id="nav">
		<a href="${config.forumurl}" class="home">${config.forumtitle}</a>  &raquo; <a href="usercp.action">用户中心</a>  &raquo; <strong>更改密码</strong>
	</div>
	<div id="headsearch">
		<div id="search">
			<@comm.quicksearch/>
		</div>
	</div>
</div>

<!--主体-->
<div class="controlpannel">
   <@comm.menu/>
	<div class="pannelcontent">
		<div class="pcontent">
			<div class="panneldetail">
				<@comm.permenu/>	
				<div class="pannelbody">
					<div class="pannellist">
					<#if reqcfg.page_err==0>
						<#if ispost>
							<@comm.msgbox/>
						<#else>
						<form action="" method="post" ID="Form1">
						<label for="oldpassword">原密码:</label>
						<input name="oldpassword" type="password" id="oldpassword" size="20" />
						<br />
						<label for="newpassword">新密码:</label>
						<input name="newpassword" type="password" id="newpassword" size="20" /> 注:新密码为空将不对密码进行修改,密码区分大小写
						<br />
						<label for="newpassword2">重复新密码:</label>
						<input name="newpassword2" type="password" id="newpassword2" size="20" />
						<br />
						<div style="line-height:180%;">
						<label for="location">安全问题:</label>
							<select name="question" id="question">
								<option value="0" selected="selected">无</option>
								<option value="1">母亲的名字</option>
								<option value="2">爷爷的名字</option>
								<option value="3">父亲出生的城市</option>
								<option value="4">您其中一位老师的名字</option>
								<option value="5">您个人计算机的型号</option>
								<option value="6">您最喜欢的餐馆名称</option>
								<option value="7">驾驶执照的最后四位数字</option>
							</select><input type="checkbox" name="changesecques" value="1" ID="Checkbox1"/>修改安全提问
						</div>
						<br style="height:1px;line-height:5px;"/>
						<label for="bday">答案:</label>
						<input name="answer" type="text" id="answer" size="20" />&nbsp;注:问题答案区分大小写<br />
						<br style="height:1px;line-height:5px;"/>
						<#if isseccode>
	                    <label for="bday">验证码:</label>
	                    <span class="formcode"> <@comm.vcode/></span>
	                    <br style="height:1px;line-height:5px;"/>
	                    </#if>
						<label for="Submit">&nbsp;</label><input type="submit" name="Submit" value="确定" ID="Submit1"/>
						</form>
						</#if>
						</div>
					<#else>
					<@comm.usercperrmsgbox/>
					</#if>
			  </div>
			</div>
		</div>
	</div>
</div>
<!--主体-->
</div>
<@comm.copyright/>
<@comm.footer/>