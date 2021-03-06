<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>查看具体批次明细 - 医院药品库存管理系统</title>
		<meta name="description" content="查看具体批次明细 - 医院药品库存管理系统" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="../assets/css/bootstrap.min.css" />
		<link rel="stylesheet" href="../assets/font-awesome/4.5.0/css/font-awesome.min.css" />
		<!-- page specific plugin styles -->
		<!-- text fonts -->
		<link rel="stylesheet" href="../assets/css/fonts.googleapis.com.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="../assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="../assets/css/ace-part2.min.css" class="ace-main-stylesheet" />
		<![endif]-->
		<link rel="stylesheet" href="../assets/css/ace-skins.min.css" />
		<link rel="stylesheet" href="../assets/css/ace-rtl.min.css" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="../assets/css/ace-ie.min.css" />
		<![endif]-->
		<!-- inline styles related to this page -->
		<!-- ace settings handler -->
		<script src="../assets/js/ace-extra.min.js"></script>
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		<!--[if lte IE 8]>
			<script src="../assets/js/html5shiv.min.js"></script>
			<script src="../assets/js/respond.min.js"></script>
		<![endif]-->
	</head>
	<body class="no-skin">
		<div id="navbar" class="navbar navbar-default ace-save-state">
			<div class="navbar-container ace-save-state" id="navbar-container">
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<div class="navbar-header pull-left">
					<a href="../nurse/index" class="navbar-brand">
						<small>
							<i class="fa fa-leaf"></i>
							医院药品库存管理系统 DIMS
						</small>
					</a>
				</div>
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="grey dropdown-modal">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-tasks"></i>
								<span class="badge badge-grey">3</span>
							</a>
							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-check"></i>
									统计信息
								</li>
								<li class="dropdown-content">
									<ul class="dropdown-menu dropdown-navbar">
										<li>
											<a href="../nurse/query-solved-rx-list">
												<div class="clearfix">
													<span class="pull-left">已处理处方数目占比</span>
													<span class="pull-right">
														<fmt:formatNumber value="${solvedRxsNum / (solvedRxsNum + unsolvedRxsNum) * 100}" pattern="#.00"/>
														%
													</span>
												</div>
												<div class="progress progress-mini progress-striped active">
													<div style="width:${solvedRxsNum / (solvedRxsNum + unsolvedRxsNum) * 100}%" class="progress-bar"></div>
												</div>
											</a>
										</li>
										<li>
											<a href="../nurse/query-unsolved-rx-list">
												<div class="clearfix">
													<span class="pull-left">未处理处方数目占比</span>
													<span class="pull-right">
														<fmt:formatNumber value="${unsolvedRxsNum / (solvedRxsNum + unsolvedRxsNum) * 100}" pattern="#.00"/>
														%
													</span>
												</div>
												<div class="progress progress-mini progress-striped active">
													<div style="width:${unsolvedRxsNum / (solvedRxsNum + unsolvedRxsNum) * 100}%" class="progress-bar progress-bar-warning"></div>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<div class="clearfix">
													<span class="pull-left">由我处理的处方数目占比</span>
													<span class="pull-right">
														<fmt:formatNumber value="${mySolvedRxsNum / solvedRxsNum * 100}" pattern="#.00"/>
														%
													</span>
												</div>
												<div class="progress progress-mini progress-striped active">
													<div style="width:${mySolvedRxsNum / solvedRxsNum * 100}%" class="progress-bar progress-bar-success"></div>
												</div>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						<li class="light-blue dropdown-modal">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="../assets/images/avatars/${currentNurse.nsex ? 'Male' : 'Female'}Nurse.png" alt="头像" />
								<span class="user-info">
									<small>欢迎，</small>
									${currentNurse.nname}
								</span>
								<i class="ace-icon fa fa-caret-down"></i>
							</a>
							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="../nurse/profile">
										<i class="ace-icon fa fa-user"></i>
										个人信息
									</a>
								</li>
								<li class="divider"></li>
								<li>
									<a href="../logout">
										<i class="ace-icon fa fa-power-off"></i>
										登出
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div><!-- /.navbar-container -->
		</div>
		<div class="main-container ace-save-state" id="main-container">
			<script type="text/javascript">
				try{ace.settings.loadState('main-container')}catch(e){}
			</script>
			<div id="sidebar" class="sidebar responsive ace-save-state">
				<script type="text/javascript">
					try{ace.settings.loadState('sidebar')}catch(e){}
				</script>
				<div class="sidebar-shortcuts" id="sidebar-shortcuts">
					<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
						<button class="btn btn-success">
							<i class="ace-icon fa fa-signal"></i>
						</button>
						<button class="btn btn-info">
							<i class="ace-icon fa fa-pencil"></i>
						</button>
						<button class="btn btn-warning">
							<i class="ace-icon fa fa-users"></i>
						</button>
						<button class="btn btn-danger">
							<i class="ace-icon fa fa-cogs"></i>
						</button>
					</div>
					<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>
						<span class="btn btn-info"></span>
						<span class="btn btn-warning"></span>
						<span class="btn btn-danger"></span>
					</div>
				</div><!-- /.sidebar-shortcuts -->
				<ul class="nav nav-list">
					<li class="">
						<a href="../nurse/welcome">
							<i class="menu-icon fa fa-tachometer"></i>
							<span class="menu-text"> 欢迎页面 </span>
						</a>
						<b class="arrow"></b>
					</li>
					<li class="">
						<a href="../nurse/profile">
							<i class="menu-icon fa fa-tag"></i>
							<span class="menu-text"> 个人信息页面 </span>
						</a>
						<b class="arrow"></b>
					</li>
					<li class="active open">
						<a href="#" class="dropdown-toggle">
							<i class="menu-icon fa fa-list"></i>
							<span class="menu-text"> 查看药品库存列表 </span>
							<b class="arrow fa fa-angle-down"></b>
						</a>
						<b class="arrow"></b>
						<ul class="submenu">
							<li class="">
								<a href="../nurse/query-drug-list">
									<i class="menu-icon fa fa-caret-right"></i>
									查看药品库存列表
								</a>
								<b class="arrow"></b>
							</li>
							<li class="active">
								<a href="../nurse/query-pdbatch-list">
									<i class="menu-icon fa fa-caret-right"></i>
									查看具体批次明细
								</a>
								<b class="arrow"></b>
							</li>
						</ul>
					</li>
					<li class="">
						<a href="#" class="dropdown-toggle">
							<i class="menu-icon fa fa-list-alt"></i>
							<span class="menu-text"> 查看处方列表 </span>
							<b class="arrow fa fa-angle-down"></b>
						</a>
						<b class="arrow"></b>
						<ul class="submenu">
							<li class="">
								<a href="../nurse/query-unsolved-rx-list">
									<i class="menu-icon fa fa-caret-right"></i>
									查看未处理处方列表
								</a>
								<b class="arrow"></b>
							</li>
							<li class="">
								<a href="../nurse/query-solved-rx-list">
									<i class="menu-icon fa fa-caret-right"></i>
									查看已处理处方列表
								</a>
								<b class="arrow"></b>
							</li>
						</ul>
					</li>
					<li class="">
						<a href="#" class="dropdown-toggle">
							<i class="menu-icon fa fa-pencil-square-o"></i>
							<span class="menu-text"> 查看处方 / 处理处方 </span>
							<b class="arrow fa fa-angle-down"></b>
						</a>
						<b class="arrow"></b>
						<ul class="submenu">
							<li class="">
								<a href="../nurse/query-rx?Pno=1">
									<i class="menu-icon fa fa-caret-right"></i>
									查看处方的具体明细
								</a>
								<b class="arrow"></b>
							</li>
							<li class="">
								<a href="form-elements-2.html">
									<i class="menu-icon fa fa-caret-right"></i>
									处理未处理处方
								</a>
								<b class="arrow"></b>
							</li>
						</ul>
					</li>
				</ul><!-- /.nav-list -->
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>
			</div>
			<div class="main-content">
				<div class="main-content-inner">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="../nurse/index">首页</a>
							</li>
							<li>
								<a href="../nurse/query-drug-list">查看药品库存列表</a>
							</li>
							<li class="active">查看具体批次明细</li>
						</ul><!-- /.breadcrumb -->
					</div>
					<div class="page-content">
						<div class="page-header">
							<h1>
								查看药品库存列表
								<small>
									<i class="ace-icon fa fa-angle-double-right"></i>
									查看具体批次明细
								</small>
							</h1>
						</div><!-- /.page-header -->
						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="row">
									<div class="col-xs-12">
										<table id="simple-table" class="table table-bordered table-hover">
											<thead>
												<tr>
													<th class="detail-col">明细</th>
													<th>药品编号</th>
													<th>药品名称</th>
													<th>药品保质期 (天数)</th>
													<th>药品数量</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${drugs}" var="drug">
													<tr>
														<td class="center">
															<div class="action-buttons">
																<a href="#" class="green bigger-140 show-details-btn" title="具体明细">
																	<i class="ace-icon fa fa-angle-double-down"></i>
																	<span class="sr-only">具体明细</span>
																</a>
															</div>
														</td>
														<td>${drug.PDno}</td>
														<td>${drug.PDname}</td>
														<td>${drug.PDlife}</td>
														<td>${drug.PDnum}</td>
														<td>
															<div class="hidden-sm hidden-xs btn-group">
																<button class="btn btn-xs btn-success">
																	<i class="ace-icon fa fa-check bigger-120"></i>
																</button>
																<button class="btn btn-xs btn-info">
																	<i class="ace-icon fa fa-pencil bigger-120"></i>
																</button>
																<button class="btn btn-xs btn-danger">
																	<i class="ace-icon fa fa-trash-o bigger-120"></i>
																</button>
																<button class="btn btn-xs btn-warning">
																	<i class="ace-icon fa fa-flag bigger-120"></i>
																</button>
															</div>
															<div class="hidden-md hidden-lg">
																<div class="inline pos-rel">
																	<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
																		<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																	</button>
																	<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																		<li>
																			<a href="#" class="tooltip-info" data-rel="tooltip" title="View">
																				<span class="blue">
																					<i class="ace-icon fa fa-search-plus bigger-120"></i>
																				</span>
																			</a>
																		</li>
																		<li>
																			<a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
																				<span class="green">
																					<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																				</span>
																			</a>
																		</li>
																		<li>
																			<a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
																				<span class="red">
																					<i class="ace-icon fa fa-trash-o bigger-120"></i>
																				</span>
																			</a>
																		</li>
																	</ul>
																</div>
															</div>
														</td>
													</tr>
													<tr class="detail-row">
														<td colspan="8">
															<div class="table-detail">
																<div class="row">
																	<div class="col-xs-12 col-sm-9">
																		<table id="simple-table" class="table table-bordered table-hover">
																			<thead>
																				<tr>
																					<th>药品批次</th>
																					<th>药品数量</th>
																					<th>药品供应商</th>
																					<th>药品入库管理员</th>
																					<th>药品入库时间</th>
																					<th>操作</th>
																				</tr>
																			</thead>
																			<tbody>
																				<c:forEach items="${drug.inventoryDrugs}" var="batch">
																					<tr>
																						<td>
																							<fmt:formatDate value="${batch.PDbatch}" pattern="yyyy 年 MM 月 dd 日"/>
																						</td>
																						<td>${batch.PDnum}</td>
																						<td>${batch.sno}</td>
																						<td>${batch.SAno}</td>
																						<td>
																							<fmt:formatDate value="${batch.stime}" pattern="yyyy 年 MM 月 dd 日 HH:mm:ss"/>
																						</td>
																						<td>
																							<div class="hidden-sm hidden-xs btn-group">
																								<button class="btn btn-xs btn-success">
																									<i class="ace-icon fa fa-check bigger-120"></i>
																								</button>
																								<button class="btn btn-xs btn-info">
																									<i class="ace-icon fa fa-pencil bigger-120"></i>
																								</button>
																								<button class="btn btn-xs btn-danger">
																									<i class="ace-icon fa fa-trash-o bigger-120"></i>
																								</button>
																								<button class="btn btn-xs btn-warning">
																									<i class="ace-icon fa fa-flag bigger-120"></i>
																								</button>
																							</div>
																							<div class="hidden-md hidden-lg">
																								<div class="inline pos-rel">
																									<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
																										<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																									</button>
																									<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																										<li>
																											<a href="#" class="tooltip-info" data-rel="tooltip" title="View">
																												<span class="blue">
																													<i class="ace-icon fa fa-search-plus bigger-120"></i>
																												</span>
																											</a>
																										</li>
																										<li>
																											<a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
																												<span class="green">
																													<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																												</span>
																											</a>
																										</li>
																										<li>
																											<a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
																												<span class="red">
																													<i class="ace-icon fa fa-trash-o bigger-120"></i>
																												</span>
																											</a>
																										</li>
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																				</c:forEach>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div><!-- /.span -->
								</div><!-- /.row -->
								<div class="hr hr-18 dotted hr-double"></div>
								<h4 class="pink">
									<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
									<a href="#modal-table" role="button" class="green" data-toggle="modal"> Table Inside a Modal Box </a>
								</h4>
								<div class="hr hr-18 dotted hr-double"></div>
								<div id="modal-table" class="modal fade" tabindex="-1">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header no-padding">
												<div class="table-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
														<span class="white">&times;</span>
													</button>
													Results for "Latest Registered Domains
												</div>
											</div>
											<div class="modal-body no-padding">
												<table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
													<thead>
														<tr>
															<th>Domain</th>
															<th>Price</th>
															<th>Clicks</th>
															<th>
																<i class="ace-icon fa fa-clock-o bigger-110"></i>
																Update
															</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>
																<a href="#">ace.com</a>
															</td>
															<td>$45</td>
															<td>3,330</td>
															<td>Feb 12</td>
														</tr>
														<tr>
															<td>
																<a href="#">base.com</a>
															</td>
															<td>$35</td>
															<td>2,595</td>
															<td>Feb 18</td>
														</tr>
														<tr>
															<td>
																<a href="#">max.com</a>
															</td>
															<td>$60</td>
															<td>4,400</td>
															<td>Mar 11</td>
														</tr>
														<tr>
															<td>
																<a href="#">best.com</a>
															</td>
															<td>$75</td>
															<td>6,500</td>
															<td>Apr 03</td>
														</tr>
														<tr>
															<td>
																<a href="#">pro.com</a>
															</td>
															<td>$55</td>
															<td>4,250</td>
															<td>Jan 21</td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="modal-footer no-margin-top">
												<button class="btn btn-sm btn-danger pull-left" data-dismiss="modal">
													<i class="ace-icon fa fa-times"></i>
													Close
												</button>
												<ul class="pagination pull-right no-margin">
													<li class="prev disabled">
														<a href="#">
															<i class="ace-icon fa fa-angle-double-left"></i>
														</a>
													</li>
													<li class="active">
														<a href="#">1</a>
													</li>
													<li>
														<a href="#">2</a>
													</li>
													<li>
														<a href="#">3</a>
													</li>
													<li class="next">
														<a href="#">
															<i class="ace-icon fa fa-angle-double-right"></i>
														</a>
													</li>
												</ul>
											</div>
										</div><!-- /.modal-content -->
									</div><!-- /.modal-dialog -->
								</div>
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content -->
				</div>
			</div><!-- /.main-content -->
			<div class="footer">
				<div class="footer-inner">
					<div class="footer-content">
						<span class="bigger-120">
							<span class="blue bolder">医院药品库存管理系统</span>
							DIMS &copy; 2019-2020
						</span>
					</div>
				</div>
			</div>
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->
		<!-- basic scripts -->
		<!--[if !IE]> -->
			<script src="../assets/js/jquery-2.1.4.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
			<script src="../assets/js/jquery-1.11.3.min.js"></script>
		<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="../assets/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="../assets/js/jquery.dataTables.min.js"></script>
		<script src="../assets/js/jquery.dataTables.bootstrap.min.js"></script>
		<script src="../assets/js/dataTables.buttons.min.js"></script>
		<script src="../assets/js/buttons.flash.min.js"></script>
		<script src="../assets/js/buttons.html5.min.js"></script>
		<script src="../assets/js/buttons.print.min.js"></script>
		<script src="../assets/js/buttons.colVis.min.js"></script>
		<script src="../assets/js/dataTables.select.min.js"></script>
		<!-- ace scripts -->
		<script src="../assets/js/ace-elements.min.js"></script>
		<script src="../assets/js/ace.min.js"></script>
		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
				//And for the first simple table, which doesn't have TableTools or dataTables
				//select/deselect all rows according to table header checkbox
				var active_class = 'active';
				$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
					var th_checked = this.checked;//checkbox inside "TH" table header
					
					$(this).closest('table').find('tbody > tr').each(function(){
						var row = this;
						if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
						else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
					});
				});
				//select/deselect a row when the checkbox is checked/unchecked
				$('#simple-table').on('click', 'td input[type=checkbox]' , function(){
					var $row = $(this).closest('tr');
					if($row.is('.detail-row ')) return;
					if(this.checked) $row.addClass(active_class);
					else $row.removeClass(active_class);
				});
				/********************************/
				//add tooltip for small view action buttons in dropdown menu
				$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				//tooltip placement on right or left
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('table')
					var off1 = $parent.offset();
					var w1 = $parent.width();
					var off2 = $source.offset();
					//var w2 = $source.width();
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
				/***************/
				$('.show-details-btn').on('click', function(e) {
					e.preventDefault();
					$(this).closest('tr').next().toggleClass('open');
					$(this).find(ace.vars['.icon']).toggleClass('fa-angle-double-down').toggleClass('fa-angle-double-up');
				});
				/***************/
				/**
				//add horizontal scrollbars to a simple table
				$('#simple-table').css({'width':'2000px', 'max-width': 'none'}).wrap('<div style="width: 1000px;" />').parent().ace_scroll(
				  {
					horizontal: true,
					styleClass: 'scroll-top scroll-dark scroll-visible',//show the scrollbars on top(default is bottom)
					size: 2000,
					mouseWheelLock: true
				  }
				).css('padding-top', '12px');
				*/
			})
		</script>
	</body>
</html>
