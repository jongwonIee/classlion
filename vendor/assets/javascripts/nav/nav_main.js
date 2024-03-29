jQuery(document).ready(function(){
	//cache DOM elements
	var mainContent = $('.cd-main-content'),
		header = $('.cd-main-header'),
		sidebar = $('.cd-side-nav'),
		sidebarTrigger = $('.cd-nav-trigger'),
		topNavigation = $('.cd-top-nav'),
		searchForm = $('.cd-search'),
		
		pointInfo = $('.point_info'),
		lecInfo = $('.lec_open'),
		wikiInfo = $('.wiki_open'),
		accountInfo = $('.account');

	//on resize, move search and top nav position according to window width
	var resizing = false;
	moveNavigation();
	$(window).on('resize', function(){
		if( !resizing ) {
			(!window.requestAnimationFrame) ? setTimeout(moveNavigation, 300) : window.requestAnimationFrame(moveNavigation);
			resizing = true;
		}
	});

	//on window scrolling - fix sidebar nav
	var scrolling = false;
	checkScrollbarPosition();
	$(window).on('scroll', function(){
		if( !scrolling ) {
			(!window.requestAnimationFrame) ? setTimeout(checkScrollbarPosition, 300) : window.requestAnimationFrame(checkScrollbarPosition);
			scrolling = true;
		}
	});

	//mobile only - open sidebar when user clicks the hamburger menu
	sidebarTrigger.on('click', function(event){
		event.preventDefault();
		$([sidebar, sidebarTrigger]).toggleClass('nav-is-visible');
	});

	//click on item and show submenu
	$('.has-children > a').on('click', function(event){
		var mq = checkMQ(),
			selectedItem = $(this);
		if( mq == 'mobile' || mq == 'tablet' ) {
			event.preventDefault();
			if( selectedItem.parent('li').hasClass('selected')) {
				selectedItem.parent('li').removeClass('selected');
			} else {
				sidebar.find('.has-children.selected').removeClass('selected');
				$('.nvs').removeClass('selected');
				// accountInfo.removeClass('selected');
				selectedItem.parent('li').addClass('selected');
			}
		}
	});
	
	
	//click on nav 오른쪽 사이드 메뉴들 and show submenu - desktop version only
	$('.has-children > a').on('click', function(event){
		var mq = checkMQ(),
			selectedItem = $(this);
		if( mq == 'desktop') {
			event.preventDefault();
			//선택된 것 있으면 해제해주고
			topNavigation.find('.has-children.selected').removeClass('selected');
			//새로 오픈
			selectedItem.parent('li').toggleClass('selected');
		}
	});

	$(document).on('click', function(event){
		var selectedItem = $(this);
		if( !$(event.target).is('.has-children a') ) {
			topNavigation.find('.has-children.selected').removeClass('selected');
			selectedItem.parent('li').removeClass('selected');
		}
	});
	
	
	
	
	
	// //point
	// //click on account and show submenu - desktop version only
	// pointInfo.children('a').on('click', function(event){
	// 	var mq = checkMQ(),
	// 		selectedItem = $(this);
	// 	if( mq == 'desktop') {
	// 		event.preventDefault();
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		pointInfo.toggleClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 	}
	// });

	// $(document).on('click', function(event){
	// 	if( !$(event.target).is('.has-children a') ) {
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 		pointInfo.removeClass('selected');
	// 	}
	// });
	
	
	// //강평열람
	// //click on account and show submenu - desktop version only
	// lecInfo.children('a').on('click', function(event){
	// 	var mq = checkMQ(),
	// 		selectedItem = $(this);
	// 	if( mq == 'desktop') {
	// 		event.preventDefault();
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		lecInfo.toggleClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 	}
	// });

	// $(document).on('click', function(event){
	// 	if( !$(event.target).is('.has-children a') ) {
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 		lecInfo.removeClass('selected');
	// 	}
	// });
	
	
	// //위키열람
	// //click on account and show submenu - desktop version only
	// wikiInfo.children('a').on('click', function(event){
	// 	var mq = checkMQ(),
	// 		selectedItem = $(this);
	// 	if( mq == 'desktop') {
	// 		event.preventDefault();
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		wikiInfo.toggleClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 	}
	// });

	// $(document).on('click', function(event){
	// 	if( !$(event.target).is('.has-children a') ) {
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 		wikiInfo.removeClass('selected');
	// 	}
	// });
	
	
	// //account
	// //click on account and show submenu - desktop version only
	// accountInfo.children('a').on('click', function(event){
	// 	var mq = checkMQ(),
	// 		selectedItem = $(this);
	// 	if( mq == 'desktop') {
	// 		event.preventDefault();
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		accountInfo.toggleClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 	}
	// });

	// $(document).on('click', function(event){
	// 	if( !$(event.target).is('.has-children a') ) {
	// 		topNavigation.find('.has-children.selected').removeClass('selected');
	// 		// sidebar.find('.has-children.selected').removeClass('selected');
	// 		accountInfo.removeClass('selected');
	// 	}
	// });

	//on desktop - differentiate between a user trying to hover over a dropdown item vs trying to navigate into a submenu's contents
	sidebar.children('ul').menuAim({
        activate: function(row) {
        	$(row).addClass('hover');
        },
        deactivate: function(row) {
        	$(row).removeClass('hover');
        },
        exitMenu: function() {
        	sidebar.find('.hover').removeClass('hover');
        	return true;
        },
        submenuSelector: ".has-children",
    });

	function checkMQ() {
		//check if mobile or desktop device
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
      return 'mobile'
    }else{
      return 'desktop'
    }
	}

	function moveNavigation(){
    var mq = checkMQ();
      
    if ( mq == 'mobile' && topNavigation.parents('.cd-side-nav').length == 0 ) {
      detachElements();
      topNavigation.appendTo(sidebar);
      searchForm.removeClass('is-hidden').prependTo(sidebar);
    } else if ( ( mq == 'tablet' || mq == 'desktop') &&  topNavigation.parents('.cd-side-nav').length > 0 ) {
      detachElements();
      searchForm.insertAfter(header.find('.cd-logo'));
      topNavigation.appendTo(header.find('.cd-nav'));
    }
		checkSelected(mq);
		resizing = false;
	}

	function detachElements() {
		topNavigation.detach();
		searchForm.detach();
	}

	function checkSelected(mq) {
		//on desktop, remove selected class from items selected on mobile/tablet version
		if( mq == 'desktop' ) $('.has-children.selected').removeClass('selected');
	}

	function checkScrollbarPosition() {
		var mq = checkMQ();
		
		if( mq != 'mobile' ) {
			var sidebarHeight = sidebar.outerHeight(),
				windowHeight = $(window).height(),
				mainContentHeight = mainContent.outerHeight(),
				scrollTop = $(window).scrollTop();

			( ( scrollTop + windowHeight > sidebarHeight ) && ( mainContentHeight - sidebarHeight != 0 ) ) ? sidebar.addClass('is-fixed').css('bottom', 0) : sidebar.removeClass('is-fixed').attr('style', '');
		}
		scrolling = false;
	}
});
