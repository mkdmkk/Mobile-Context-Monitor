<%@ page import="mcm.dto.*"%>
<%
	MemberDTO memberDTO = (MemberDTO) session.getAttribute("MEMBER_INFO");
%>
<div id="header" class="size-width-default center margin-top-small"
			style="height: 40px">
			<section>
				<article class="size-width-half float-left margin-left-small">
					<a href="http://112.171.82.244:8080/MobileContextMonitor/">
						<canvas id="logo" width="80" height="40">Wait...</canvas> </a>
						<script>
						var ctx = document.getElementById('logo').getContext('2d');
						ctx.textBaseline = "top";
						ctx.font = "bold 32pt Courier New";
						ctx.fillStyle = "#CC3910";
						ctx.fillText("MCM", 0, 0);
						</script>
				</article>
				<article class="size-width-one-third float-right margin-top-middle"
					style="height: 32px">
					<div class="size-width-max text-right">
						<%
							if (memberDTO != null) {
						%>
						<table class="size-width-half right">
							<tr>
								<td class="text-right"><%=memberDTO.getName()%></td>
								<td class="text-right"><a
									href="MemberManager?actionType=signOut">Sign-out</a>
								</td>
							</tr>
						</table>
						<%
							} else {
						%>
						<form id="signForm" action="MemberManager?actionType=signIn"
							method="post">
							<table class="size-width-max right">
								<tr>
									<td><input type="email" name="email" id="email"
										placeholder="E-mail Address">
									</td>
									<td><input type="password" name="pw"
										placeholder="Password">
									</td>
									<td><input type="submit" value="Sign-in">
									</td>
									<td><input type="button" value="Sign-up"
										onclick="contentFrame.location.href='signUpPage.jsp'"
										class="transparent">
									</td>
								</tr>
							</table>
						</form>
						<%
							}
						%>
					</div>
				</article>
			</section>
		</div>