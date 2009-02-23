﻿<#-- 
	描述：附件信息模板 
	作者：黄磊 
	版本：v1.0 
-->										
									<dl class="t_attachlist">
											<dt>
											<img class="absmiddle" border="0" alt="" src="images/fileicons/${attachment.description.trim()?default("default")}.gif"/>
											<a class="bold" target="_blank" href="attachment.action?attachmentid=${attachment.aid}">${attachment.attachment}</a>
											<em>(<script type="text/javascript">ShowFormatBytesStr(${attachment.filesize.toString()});</script>)</em>
											</dt>
											<dd>
											<p> ${attachment.postdatetime} </p>
											<#if attachment.preview!="">
											<p>${attachment.preview}</p>
											</#if>

											<p>
										<#if allowdownloadattach><!--当用户有下载附件权限时-->
											<#if config.showimages==1>
												<#if config.attachimgpost==1>
													<#if attachment.attachimgpost==1>
														<img alt="${attachment.attachment}" 
														<#if config.showattachmentpath==1>
															src="upload/${attachment.filename}"
														<#else>
															src="attachment.action?attachmentid=${attachment.aid}"
														</#if>
													onmouseover="attachimg(this, 'mouseover')" onload="attachimg(this, 'load');" onclick="zoom(this, this.src);" />
													</#if>
												</#if>
												<br />
											</#if>
										<#else>
											<span class="attachnotdown">您所在的用户组无法下载或查看附件</span>
										</#if>	
											</p>
											</dd>										
										</dl>
