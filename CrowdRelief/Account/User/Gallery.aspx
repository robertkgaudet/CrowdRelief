<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureUser.master" AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="Account_RecoveryDashboard_Gallery" %>

<asp:Content ID="Content1" ContentPlaceholderID="HeadContentPlaceHolder" Runat="Server">
    <link rel="stylesheet" href="vendor/blueimp-gallery/css/blueimp-gallery.min.css" />
	<script src="vendor/iCheck/icheck.min.js"></script>
	<script src="vendor/sparkline/index.js"></script>
	<script src="vendor/blueimp-gallery/js/jquery.blueimp-gallery.min.js"></script>
<!-- Local style for demo purpose -->
<style>

    .lightBoxGallery {
        text-align: center;
    }

    .lightBoxGallery a {
        margin: 5px;
        display: inline-block;
    }

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceholderID="BodyContentPlaceHolder1" Runat="Server">
	
    <div class="normalheader ">
        <div class="hpanel">
            <div class="panel-body">
                <a class="small-header-action" href="">
                    <div class="clip-header">
                        <i class="fa fa-arrow-up"></i>
                    </div>
                </a>

                <div id="hbreadcrumb" class="pull-right m-t-lg">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="index.html">Dashboard</a></li>
                        <li>
                            <span>Charts</span>
                        </li>
                        <li class="active">
                            <span>Gallery </span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    Gallery
                </h2>
                <small>Touch-enabled, responsive and customizable image & video gallery.</small>
            </div>
        </div>
    </div>

    <div class="content">
        <div class="row">
            <div class="col-lg-12">
                <div class="hpanel">
                    <div class="panel-body">

                        <div class="lightBoxGallery">

                            <p>
                                <strong>Blueimp Gallery</strong>  is a touch-enabled, responsive and customizable image & video gallery, carousel and
                                lightbox, optimized for both mobile and desktop web browsers.
                                It features swipe, mouse and keyboard navigation, transition effects, slideshow
                                functionality, fullscreen support and on-demand content loading and can be extended to
                                display additional content types.
                            </p>

                            <a href="images/gallery/1.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/1s.jpg"></a>
                            <a href="images/gallery/2.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/2s.jpg"></a>
                            <a href="images/gallery/3.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/3s.jpg"></a>
                            <a href="images/gallery/4.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/4s.jpg"></a>
                            <a href="images/gallery/5.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/5s.jpg"></a>
                            <a href="images/gallery/6.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/6s.jpg"></a>
                            <a href="images/gallery/7.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/7s.jpg"></a>
                            <a href="images/gallery/8.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/8s.jpg"></a>
                            <a href="images/gallery/9.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/9s.jpg"></a>
                            <a href="images/gallery/10.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/10s.jpg"></a>

                            <a href="images/gallery/1.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/1s.jpg"></a>
                            <a href="images/gallery/2.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/2s.jpg"></a>
                            <a href="images/gallery/3.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/3s.jpg"></a>
                            <a href="images/gallery/4.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/4s.jpg"></a>
                            <a href="images/gallery/5.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/5s.jpg"></a>
                            <a href="images/gallery/6.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/6s.jpg"></a>
                            <a href="images/gallery/7.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/7s.jpg"></a>
                            <a href="images/gallery/8.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/8s.jpg"></a>
                            <a href="images/gallery/9.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/9s.jpg"></a>
                            <a href="images/gallery/10.jpg" title="Image from Unsplash" data-gallery=""><img src="images/gallery/10s.jpg"></a>


                        </div>





                    </div>
                    <div class="panel-footer">
                        <i class="fa fa-picture-o"> </i> 20 pimages
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Right sidebar -->
    <div id="right-sidebar" class="animated fadeInRight">

        <div class="p-m">
            <button id="sidebar-close" class="right-sidebar-toggle sidebar-button btn btn-default m-b-md"><i class="pe pe-7s-close"></i>
            </button>
            <div>
                <span class="font-bold no-margins"> Analytics </span>
                <br>
                <small> Lorem Ipsum is simply dummy text of the printing simply all dummy text.</small>
            </div>
            <div class="row m-t-sm m-b-sm">
                <div class="col-lg-6">
                    <h3 class="no-margins font-extra-bold text-success">300,102</h3>

                    <div class="font-bold">98% <i class="fa fa-level-up text-success"></i></div>
                </div>
                <div class="col-lg-6">
                    <h3 class="no-margins font-extra-bold text-success">280,200</h3>

                    <div class="font-bold">98% <i class="fa fa-level-up text-success"></i></div>
                </div>
            </div>
            <div class="progress m-t-xs full progress-small">
                <div style="width: 25%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="25" role="progressbar"
                     class=" progress-bar progress-bar-success">
                    <span class="sr-only">35% Complete (success)</span>
                </div>
            </div>
        </div>
        <div class="p-m bg-light border-bottom border-top">
            <span class="font-bold no-margins"> Social talks </span>
            <br>
            <small> Lorem Ipsum is simply dummy text of the printing simply all dummy text.</small>
            <div class="m-t-md">
                <div class="social-talk">
                    <div class="media social-profile clearfix">
                        <a class="pull-left">
                            <img src="images/a1.jpg" alt="profile-picture">
                        </a>

                        <div class="media-body">
                            <span class="font-bold">John Novak</span>
                            <small class="text-muted">21.03.2015</small>
                            <div class="social-content small">
                                Injected humour, or randomised words which don't look even slightly believable.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="social-talk">
                    <div class="media social-profile clearfix">
                        <a class="pull-left">
                            <img src="images/a3.jpg" alt="profile-picture">
                        </a>

                        <div class="media-body">
                            <span class="font-bold">Mark Smith</span>
                            <small class="text-muted">14.04.2015</small>
                            <div class="social-content">
                                Many desktop publishing packages and web page editors.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="social-talk">
                    <div class="media social-profile clearfix">
                        <a class="pull-left">
                            <img src="images/a4.jpg" alt="profile-picture">
                        </a>

                        <div class="media-body">
                            <span class="font-bold">Marica Morgan</span>
                            <small class="text-muted">21.03.2015</small>

                            <div class="social-content">
                                There are many variations of passages of Lorem Ipsum available, but the majority have
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="p-m">
            <span class="font-bold no-margins"> Sales in last week </span>
            <div class="m-t-xs">
                <div class="row">
                    <div class="col-xs-6">
                        <small>Today</small>
                        <h4 class="m-t-xs">$170,20 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                    <div class="col-xs-6">
                        <small>Last week</small>
                        <h4 class="m-t-xs">$580,90 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <small>Today</small>
                        <h4 class="m-t-xs">$620,20 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                    <div class="col-xs-6">
                        <small>Last week</small>
                        <h4 class="m-t-xs">$140,70 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                </div>
            </div>
            <small> Lorem Ipsum is simply dummy text of the printing simply all dummy text.
                Many desktop publishing packages and web page editors.
            </small>
        </div>

    </div>
	
<!-- The Gallery as lightbox dialog, should be a child element of the document body -->
<div id="blueimp-gallery" class="blueimp-gallery">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>
</asp:Content>

