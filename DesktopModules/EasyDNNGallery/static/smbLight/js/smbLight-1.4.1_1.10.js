!function(e,t){"use strict";function a(t,a){var o,n=this,s="";if(O.call(n,t,a))return n.$root=e('<div class="smbLightOverlayWrapper initializing"><div class="contentWrapper" /></div>'),n.$root.addClass(n.options.cssClass),n.$contentWrapper=e("> div.contentWrapper",n.$root),t.length>1&&(s='<span class="navigation prev"><span /></span><span class="navigation next"><span /></span>'),s+='<span class="close"><span /></span><div class="socialButtonsWrapper"></div><span class="actions socialButtonsTrigger"><span>'+R.call(n,"Share")+"</span></span>",n.$mainWrapper=e('<div class="mainWrapper"><div class="viewWrapper"><div class="images"><p>'+R.call(n,"This image is currently unavailable")+'</p></div><div class="audioVideo" /></div>'+s+"</div>").appendTo(n.$contentWrapper),n.$itemTitle=e('<h2 class="itemTitle" />').appendTo(n.$mainWrapper),n.$loadingOverlay=e('<div class="loadingOverlay inProgress" />').appendTo(n.$mainWrapper),n.$imagesWrapper=e("> .viewWrapper > .images",n.$mainWrapper),n.$audioVideo=e("> .viewWrapper > .audioVideo",n.$mainWrapper),n.$socialButtonsWrapper=e(".socialButtonsWrapper",n.$mainWrapper),n.$socialButtonsTrigger=e(".socialButtonsTrigger",n.$mainWrapper),o=n.items[n.currentItemIndex],"image"==o.type?g.call(n,n.currentItemIndex,function(){$.call(n)}):$.call(n),n.$root.appendTo(n.$body),n.main={horizontalSpace:n.$mainWrapper.outerWidth(!0)-n.$mainWrapper.width(),verticalSpace:n.$mainWrapper.outerHeight(!0)-n.$mainWrapper.height()},b.call(n),n.$root.fadeTo(200,1,function(){"image"!=o.type&&x.call(n)}),P.call(n),n}function o(t,a){var o=this,n="";if(o.smbPlus=!0,O.call(o,t,a)){if(o.options.wrapperResizeDuration=0,o.$viewportMeta=e('meta[name="viewport"]'),o.oldViewportMetaContent=void 0,o.$viewportMeta.length>0?(o.oldViewportMetaContent=o.$viewportMeta.attr("content"),o.$viewportMeta.attr("content","user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1")):o.$viewportMeta=e('<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1" />').appendTo(e("head")),o.$ieTapHighlight=e('meta[name="msapplication-tap-highlight"]'),o.oldIeTapHighlight=void 0,o.$ieTapHighlight.length>0?(o.oldIeTapHighlight=o.$ieTapHighlight.attr("content"),o.$ieTapHighlight.attr("content","no")):o.$ieTapHighlight=e('<meta name="msapplication-tap-highlight" content="no" />').appendTo(e("head")),o.$root=e('<div class="smbLightOverlayWrapper smbPlus initializing"><div class="contentWrapper"></div></div>').addClass(o.options.cssClass),/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase())||(o.$root.addClass("desktopUserAgent"),o.desktopVersion=!0),o.$contentWrapper=e("> div.contentWrapper",o.$root),n='<div class="mobileOverlay" /><div class="modalOverlay" />',t.length>1&&(n+='<span class="navigation prev"><span /></span><span class="navigation next"><span /></span>'),n+='<span class="close"><span /></span><div class="socialButtonsWrapper"></div><span class="actions socialButtonsTrigger"><span>'+R.call(o,"Share")+"</span></span>",o.$root.append(n),o.$itemTitle=e('<h2 class="itemTitle" />').appendTo(o.$root),o.$socialButtonsWrapper=e(".socialButtonsWrapper",o.$root),o.$socialButtonsTrigger=e(".socialButtonsTrigger",o.$root),o.$modalOverlay=e("> .modalOverlay",o.$root),o.options.comments.permissions.show){o.comments={},o.$root.append('<span class="actions commentsTrigger"><span>0</span></span><div class="commentsModalWrapper"><div class="main"><div class="top"><span class="comments">0</span><span class="likes">0</span><span class="sort">'+R.call(o,"Sort")+'</span></div><ul /><p class="noComments">'+R.call(o,"No comments yet")+'</p><div class="newCommentWrapper"><textarea placeholder="'+R.call(o,"Write a comment")+'"></textarea><button>'+R.call(o,"Post")+'</button></div></div><div class="anonymCommentWrapper"><p>'+R.call(o,"Add a comment")+'</p><div class="authorName"><input type="text" placeholder="'+R.call(o,"Name")+'" /></div><div class="authorEmail"><input type="text" placeholder="'+R.call(o,"Email")+'" /></div><div class="authorTextarea"><textarea placeholder="'+R.call(o,"Write a comment")+'"></textarea></div>'+(o.options.comments.requireAuthorInfo&&o.options.comments.useReCaptcha?'<div class="captchaContainer"><p class="captchaError">'+R.call(o,"Please solve the test correctly.")+'</p><div class="captcha"></div></div>':"")+'<div class="actions"><button class="cancel">'+R.call(o,"Cancel")+'</button><button class="post">'+R.call(o,"Post")+'</button></div></div><span class="closeComments">'+R.call(o,"Hide")+'</span><p class="loading">'+R.call(o,"Loading comments")+"</p></div>"),o.$commentsTrigger=e("> .actions.commentsTrigger",o.$root),o.$mainCommentsCount=e("> span",o.$commentsTrigger),o.$commentsModal=e("> .commentsModalWrapper",o.$root),o.$commentsMainWrapper=e("> .main",o.$commentsModal),o.$newCommentWrapper=e("> .newCommentWrapper",o.$commentsMainWrapper),o.$newCommentInput=e("> textarea",o.$newCommentWrapper),o.$newCommentButton=e("> button",o.$newCommentWrapper),o.$commentsTopBar=e("> .top",o.$commentsMainWrapper),o.$internalCommentsCount=e("> .comments",o.$commentsTopBar),o.$commentsLikes=e("> .likes",o.$commentsTopBar),o.$commentsSorting=e("> .sort",o.$commentsTopBar),o.$commentList=e("> ul",o.$commentsMainWrapper),o.$anonymCommentWrapper=e("> .anonymCommentWrapper",o.$commentsModal),o.$anonymCommenterNameInput=e("> .authorName > input",o.$anonymCommentWrapper),o.$anonymCommenterEmailInput=e("> .authorEmail > input",o.$anonymCommentWrapper),o.$anonymCommentInput=e("> .authorTextarea > textarea",o.$anonymCommentWrapper),o.$anonymCommentCancel=e("> .actions > .cancel",o.$anonymCommentWrapper),o.$anonymCommentPost=e("> .actions > .post",o.$anonymCommentWrapper),o.$newCommentCaptchaContainer=e("> .captchaContainer",o.$anonymCommentWrapper),o.commentSorting="asc",o.addingAjaxRequest=void 0,o.commentsOpened=!1,o.commentsAnimationTimeout;var s;o.$commentsTrigger.on("click",function(){return o.desktopVersion&&1==o.commentsOpened?void o.closeComments():(o.updateItemComments(),void(o.desktopVersion?(o.commentsOpened=!0,clearTimeout(o.commentsAnimationTimeout),o.$root.addClass("animateComments moveComments"),o.commentsAnimationTimeout=setTimeout(function(){o.$root.removeClass("animateComments moveComments"),o.$root.width(o.$root.width()-o.$commentsModal.outerWidth(!0)),b.call(o)},200)):(o.$root.addClass("modalActive"),o.$modalOverlay.stop(!0).animate({opacity:1},{duration:200}))))}),o.$commentsSorting.on("click",function(){"asc"==o.commentSorting?o.commentSorting="desc":o.commentSorting="asc",o.$commentsSorting.toggleClass("desc","desc"==o.commentSorting),S.call(o)}),o.$commentsModal.on("click","> span.closeComments",function(){o.closeComments()}),o.$newCommentInput.on("change keyup",function(){var e=o.$newCommentInput.val();o.$newCommentWrapper.toggleClass("filledIn",""!==e)}).on("focus",function(){o.options.comments.requireAuthorInfo&&(o.$anonymCommenterNameInput.trigger("focus").val("").parent().removeClass("error"),o.$anonymCommenterEmailInput.val("").parent().removeClass("error"),o.$anonymCommentInput.val("").parent().removeClass("error"),o.$newCommentCaptchaContainer.removeClass("error"),o.options.comments.useReCaptcha&&(s?grecaptcha.reset(s):s=grecaptcha.render(e("> .captcha",o.$newCommentCaptchaContainer)[0],{sitekey:o.options.googleReCaptchaSiteKey,size:"compact"})),o.$commentsModal.addClass("showAnonymWindow"))}),o.$anonymCommentCancel.on("click",function(){o.$commentsModal.removeClass("showAnonymWindow"),o.$anonymCommentWrapper.removeClass("addingAnonComment"),o.addingAjaxRequest&&(o.addingAjaxRequest.abort(),o.addingAjaxRequest=void 0)});var i=function(t,a,n,s,i,r){var m=o.currentItemIndex,l=o.items[m],c=o.comments[l.id],p=o.options.comments.requireAuthorInfo?s:o.$newCommentInput.val(),d={action:"add_comment"},u=!1;""===p||o.$newCommentWrapper.hasClass("addingComment")||(o.$newCommentCaptchaContainer.removeClass("error"),o.$newCommentInput.val(""),o.$newCommentWrapper.removeClass("filledIn").addClass("addingComment"),d.comment=p,o.options.comments.requireAuthorInfo&&(d.name=a,d.email=n),i&&(d.captcha=i),o.addingAjaxRequest=e.ajax({data:d,dataType:"json",type:"POST",url:l.comments.backend,timeout:3e4,cache:!1,error:function(){},success:function(e){void 0!=e.status&&("success"==e.status?(c.cache.comments.push({author:e.author.id,content:e.comment,raw:p,id:e.id,dateHtml:e.dateHtml}),c.count+=1,void 0==c.cache.authors[e.author.id]&&(c.cache.authors[e.author.id]={avatar:e.author.avatar,name:e.author.name,url:e.author.url})):"captcha_error"==e.status&&(o.$newCommentCaptchaContainer.addClass("error"),u=!0))},complete:function(){o.addingAjaxRequest=void 0,c.state.open&&m==o.currentItemIndex&&(r&&(o.$anonymCommentWrapper.removeClass("addingAnonComment"),o.$anonymCommentPost.text(R.call(o,"Post"))),o.$newCommentWrapper.removeClass("addingComment"),u||(r&&(o.$commentsModal.removeClass("showAnonymWindow"),o.$newCommentCaptchaContainer.removeClass("error")),S.call(o)))}}))};o.$anonymCommentPost.on("click",function(){var e=o.$anonymCommenterNameInput.val(),t=o.$anonymCommenterEmailInput.val(),a=o.$anonymCommentInput.val(),n=!1,r=void 0;o.$anonymCommenterNameInput.attr("placeholder",R.call(o,"Name")),o.$anonymCommenterEmailInput.attr("placeholder",R.call(o,"Email")),o.$anonymCommentInput.attr("placeholder",R.call(o,"Write a comment")),o.$anonymCommenterNameInput.parent().removeClass("error"),o.$anonymCommenterEmailInput.parent().removeClass("error"),o.$anonymCommentInput.parent().removeClass("error"),e||(o.$anonymCommenterNameInput.attr("placeholder",R.call(o,"Please specify your name")).parent().addClass("error"),n=!0),t&&v.test(t)||(o.$anonymCommenterEmailInput.attr("placeholder",R.call(o,"Please specify your email")).parent().addClass("error"),n=!0),a||(o.$anonymCommentInput.attr("placeholder",R.call(o,"Please write a comment")).parent().addClass("error"),n=!0),o.options.comments.useReCaptcha&&(r=grecaptcha.getResponse(s),0==r.length&&(o.$newCommentCaptchaContainer.addClass("error"),n=!0)),n||(o.$anonymCommentWrapper.addClass("addingAnonComment"),o.$anonymCommentPost.text(R.call(o,"Commenting")),i({},e,t,a,r,!0))}),o.$newCommentButton.on("click",i)}o.options.like.permissions.liking&&(o.$root.append('<span class="actions likeTrigger"><span>0</span></span>'),o.$likeTrigger=e("> .actions.likeTrigger",o.$root),o.$mainLikeCount=e("> span",o.$likeTrigger),o.$likeTrigger.on("click",function(){if(!o.$root.hasClass("initializing")){var t=o.currentItemIndex,a=o.items[t],n=!a.likes.likedByUser,s={portalId:o.options.portalId,moduleId:o.options.moduleId,mediaId:a.id};a.likes.likedByUser=n,n?a.likes.numOfLikes+=1:a.likes.numOfLikes>0&&(a.likes.numOfLikes-=1),o.$mainLikeCount.text(a.likes.numOfLikes),o.$likeTrigger.toggleClass("liked",n),"number"==typeof a.journalId?(s.action="like",s.journalid=a.journalId,s.liked=n):(s.action="media_like",s.vote=n?1:-1),e.ajax({data:s,dataType:"json",type:"POST",url:o.options.websiteRoot+"DesktopModules/EasyDNNGallery/Services/SocialMediaBox.ashx",timeout:1e4,cache:!1,error:function(){},success:function(){},complete:function(){}})}})),o.$root.appendTo(o.$body),o.main={horizontalSpace:0,verticalSpace:0},e.each(o.items,function(t){var a=e("<div />");a.addClass("loading item_"+t).data("itemIndex",t),"image"==this.type?a.addClass("imageItem"):"video"==this.type?a.addClass("videoItem"):"audio"==this.type&&a.addClass("audioItem"),a.appendTo(o.$contentWrapper)}),b.call(o),o.$root.addClass("show"),setTimeout(function(){x.call(o)},200);var r=new Hammer(e("> .mobileOverlay",o.$root)[0]);o.skipGestures=!1;var m;return r.on("swipeleft swiperight panleft panright panend tap",function(e){var a=-(o.currentItemIndex*o.overlayWidth),n=e.deltaX;if("tap"==e.type)return clearTimeout(m),void(o.$root.hasClass("hideControls")?o.$root.removeClass("hideControls fadeOutControls"):(o.$root.addClass("fadeOutControls"),m=setTimeout(function(){o.$root.addClass("hideControls")},500)));if(!o.skipGestures&&o.initialItemLoaded){if(("swipeleft"==e.type||"swiperight"==e.type)&&t.length>1)return void("swipeleft"==e.type&&(o.currentItemIndex<o.items.length-1?M.call(o):0==o.currentItemIndex&&L.call(o)));if("panend"==e.type){if(0==o.currentItemIndex&&n>=0||o.currentItemIndex==o.items.length-1&&0>n||Math.abs(n)<o.overlayWidth/2)return void o.$contentWrapper.removeClass(u).addClass(d).css({transform:"translate3d("+a+"px, 0, 0)"});o.skipGestures=!0;var s=-o.overlayWidth,i=1;return n>0&&(s=o.overlayWidth,i=-1),s=a+s,o.$contentWrapper.addClass(d).removeClass(u).css({transform:"translate3d("+s+"px, 0, 0)"}),void setTimeout(function(){o.skipGestures=!1,o.currentItemIndex+=i,x.call(o)},550)}(0==o.currentItemIndex&&n>=0||o.currentItemIndex==o.items.length-1&&0>n)&&(n=1-Math.abs(n)/o.overlayWidth,.5>n?(n=Math.round(o.overlayWidth/4),e.deltaX<1&&(n=-n)):n=Math.round(n*e.deltaX)),o.$contentWrapper.removeClass(d).removeClass(u).css({transform:"translate3d("+(a+n)+"px, 0, 0)"})}}),P.call(o),o}}var n={portalId:0,moduleId:0,tabId:0,userLoggedIn:!1,googleReCaptchaSiteKey:"",websiteRoot:"",portfolioMode:!1,openAt:0,wrapperResizeDuration:200,flowplayerSwf:"",flowplayer:{key:"",logo:""},socialButtons:{facebook:!1,gplus:!1,twitter:!1,inshare:!1,pinterest:!1},cssClass:"",events:{onBeforeClose:function(){}},comments:{requireAuthorInfo:!0,useReCaptcha:!1,permissions:{show:!1,commenting:!1}},like:{permissions:{liking:!1}},mobile:!1,i18n:{}},s={UNSET:0,SENT:1,DONE:2},i="activeElement",r="imageNotLoaded",m="smbLightFixed",l="audioItem",c="videoItem",p="imageItem",d="positionAnimation",u="swipeAnimation",h="initialized",v=/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,g=function(t,a){var o=this,n=o.items[t];if("image"==n.type){var s=o.images[n.src];if(s)return void("function"==typeof a&&(s.stats.preloadFinished?a(s.stats):s.callbacks.push(a)));s=o.images[n.src]={callbacks:[],stats:{preloadFinished:!1,isLoaded:!1,width:0,height:0}},"function"==typeof a&&s.callbacks.push(a);var i=e('<img class="smbLightImage_'+n.id+'" />');i.imagesLoaded().progress(function(e,t){if(!o.viewClosed){var a=o.images[n.src];if(a.stats.preloadFinished=!0,a.stats.isLoaded=t.isLoaded,!o.smbPlus&&t.isLoaded&&o.$imagesWrapper.append(i),a.stats.width=i.width(),a.stats.height=i.height(),o.smbPlus)i.css(C.call(o,a.stats.width,a.stats.height,!1)),i.parent().removeClass("loading");else{var s=o.items[o.currentItemIndex];"image"==s.type&&s.src==n.src&&(o.initialItemLoaded=!0,x.call(o))}i=null;for(var r=0,m=a.callbacks.length;m>r;r++)a.callbacks[r](a.stats)}}),o.smbPlus&&i.appendTo(e("> div.item_"+t,o.$contentWrapper)),i.attr("src",n.src)}},$=function(){for(var e=this,t=0,a=e.items.length;a>t;t++)g.call(e,t)},C=function(e,t,a,o){var n,s,i=this,r=i.overlayWidth-i.main.horizontalSpace,m=i.overlayHeight-i.main.verticalSpace,l=e,c=t;return(a||e>r||t>m)&&(n=r/m,s=e/t,l=r,c=m,n>s?l=Math.round(m/t*e):s>n&&(c=Math.round(r/e*t))),o&&(c=t),{width:l,height:c,top:Math.floor((m-c)/2),left:Math.floor((r-l)/2)}},f=function(e){var t=this,a=function(){t.$loadingOverlay.stop(!0).fadeTo(200,0,function(){t.$loadingOverlay.css("display","none")}),W.call(t)},o=function(e,a){0==t.options.wrapperResizeDuration?(t.$mainWrapper.css(e),a()):t.$mainWrapper.stop(!0).animate(e,{duration:t.options.wrapperResizeDuration,complete:function(){t.$mainWrapper.css("overflow",""),a()}})},n=function(){t.$mainWrapper.height()!=e.height?o({height:e.height,top:e.top},a):a()};t.$loadingOverlay.removeClass("inProgress"),t.$mainWrapper.width()!=e.width?o({width:e.width,left:e.left},n):n()},I=function(t){var a,o,n=this,s=n.images[t.src].stats;s.preloadFinished&&(n.$mainWrapper.addClass(p),e("> img",n.$imagesWrapper).removeClass(i).filter(".smbLightImage_"+t.id).addClass(i),s.isLoaded?(a=s.width,o=s.height):(a=400,o=400,n.$imagesWrapper.addClass(r)),n.$imagesWrapper.addClass(i),f.call(n,C.call(n,a,o)))},w=function(t){var a=this,o="",n="",s=a.items[t];switch(a.smbPlus||a.$mainWrapper.addClass(c),s.source){case"youtube":o='<iframe src="//www.youtube.com/embed/'+s.videoId+'" frameborder="0" allowfullscreen></iframe>';break;case"vimeo":o='<iframe src="//player.vimeo.com/video/'+s.videoId+'" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';break;case"wistia":o='<iframe name="wistia_embed" src="//fast.wistia.net/embed/iframe/'+s.videoId+'" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>';break;case"flowplayer":A(s.src,".mp4")?n="video/mp4":A(s.src,".webm")?n="video/webm":A(s.src,".ogg")?n="video/ogg":A(s.src,".flv")&&(n="video/flash"),o='<div class="flowplayerContainer"></div>'}var r=a.$audioVideo;a.smbPlus?("flowplayer"!=s.source&&(o="<div>"+o+"</div>"),r=e("> div.item_"+a.currentItemIndex,a.$contentWrapper)):r.addClass(i),r.html(o).removeClass("loading"),"flowplayer"==s.source&&e("> .flowplayerContainer",r).flowplayer({swf:a.options.flowplayerSwf,ratio:s.height/s.width,tooltip:!1,embed:!1,clip:{sources:[{type:n,src:s.src}]},key:a.options.flowplayer.key,logo:a.options.flowplayer.logo});var m=C.call(a,s.width,s.height,!0);a.smbPlus?e(">",r).css(m):f.call(a,m),a.initialItemLoaded=!0},y=function(t){var a=this;a.smbPlus||a.$mainWrapper.addClass(l);var o=a.$audioVideo,n='<audio src="'+t.src+'" />',s="> audio";a.smbPlus?(n="<div>"+n+"</div>",s="> div > audio",o=e("> div.item_"+a.currentItemIndex,a.$contentWrapper)):o.addClass(i),o.html(n).removeClass("loading"),audiojs.create(e(s,o)[0]);var r=C.call(a,460,36,!1,!0);a.smbPlus?e(">",o).css(r):f.call(a,r),a.initialItemLoaded=!0},W=function(){var e=this,t=e.items[e.currentItemIndex];"string"==typeof t.title&&""!=t.title&&e.$itemTitle.text(t.title).stop(!0).fadeTo(200,1),(e.options.socialButtons.facebook||e.options.socialButtons.twitter||e.options.socialButtons.gplus||e.options.socialButtons.inshare||e.options.socialButtons.pinterest&&"image"==t.type)&&"string"==typeof t.socialUrl&&""!=t.socialUrl?e.$socialButtonsTrigger.css("display",""):e.$socialButtonsTrigger.css("display","none")},k=function(e){var t=this.items.length;return 0>e?e=t-1:e>=t&&(e=0),e},x=function(){var t=this;if(t.$itemTitle.text("").stop(!0).fadeTo(0,0),t.$socialButtonsTrigger.removeClass("show"),t.$socialButtonsWrapper.removeClass("show").html(""),t.currentItemIndex=k.call(t,t.currentItemIndex),t.$root.removeClass("firstItem lastItem"),0===t.currentItemIndex&&t.$root.addClass("firstItem"),t.currentItemIndex===t.items.length-1&&t.$root.addClass("lastItem"),t.smbPlus){var a=k.call(t,t.currentItemIndex-1),o=k.call(t,t.currentItemIndex+1);e("> div.videoItem.item_"+a+",> div.audioItem.item_"+a+",> div.videoItem.item_"+o+",> div.audioItem.item_"+o,t.$contentWrapper).html(""),W.call(t)}var n=t.items[t.currentItemIndex],s="imageActive";"video"==n.type?s="videoActive":"audio"==n.type&&(s="audioActive"),t.$root.removeClass("imageActive videoActive audioActive").addClass(s),t.showItem()},b=function(){var e=this;if(e.smbPlus){var a=e.$window.height();t.innerHeight&&(a=t.innerHeight),a+=1,e.$root.height(a),e.overlayWidth=e.$root.width(),e.overlayHeight=a}else e.overlayWidth=e.$contentWrapper.width(),e.overlayHeight=e.$contentWrapper.height();e.center()},T=function(e){var t=this;if(!(t.skipGestures||-1==e&&0==t.currentItemIndex||1==e&&t.currentItemIndex==this.items.length-1)){t.skipGestures=!0;var a=-t.currentItemIndex*t.overlayWidth;1==e?a-=t.overlayWidth:a+=t.overlayWidth,t.$contentWrapper.removeClass(d).addClass(u).css({transform:"translate3d("+a+"px, 0, 0)"}),setTimeout(function(){t.currentItemIndex+=e,x.call(t),t.skipGestures=!1},250)}},L=function(){var e=this;if(e.initialItemLoaded){if(e.smbPlus)return void T.call(e,-1);e.currentItemIndex-=1,x.call(e)}},M=function(){var e=this;if(e.initialItemLoaded){if(e.smbPlus)return void T.call(e,1);e.currentItemIndex+=1,x.call(e)}},B=function(){var e=this;("function"!=typeof e.options.events.onBeforeClose||e.options.events.onBeforeClose({activeItem:e.currentItemIndex,displayItems:e.items})!==!1)&&(e.$document.off(".smbLightEvent"),e.$window.off(".smbLightEvent"),e.viewClosed=!0,e.$root.stop(!0).fadeOut(200,function(){e.$root.remove(),e.$body.removeClass(m)}),e.smbPlus&&(void 0===e.oldViewportMetaContent?e.$viewportMeta.remove():e.$viewportMeta.attr("content",e.oldViewportMetaContent),void 0===e.oldIeTapHighlight?e.$ieTapHighlight.remove():e.$ieTapHighlight.attr("content",e.oldIeTapHighlight)))},A=function(e,t){return-1!==e.indexOf(t,e.length-t.length)},S=function(){var t=this,a=t.items[t.currentItemIndex],o=t.comments[a.id],n="";return t.$mainCommentsCount.text(o.count),t.$internalCommentsCount.text(o.count),0==o.cache.comments.length?(t.$commentList.html(""),void t.$commentsModal.addClass("noComments")):(t.$commentsModal.removeClass("noComments"),e.each(o.cache.comments,function(){var a=o.cache.authors[this.author],s=encodeURI(a.url),i='<li><a class="authorAvatar" href="'+s+'"><img src="'+encodeURI(a.avatar)+'" alt="" /></a><a class="author" href="'+s+'">'+e("<p />").text(a.name).html()+"</a><div>"+this.content+'</div><p class="datetime">'+this.dateHtml+"</p></li>";"asc"==t.commentSorting?n+=i:n=i+n}),void t.$commentList.html(n))},O=function(a,o){var s=this;return s.$body=e("body"),s.$body.hasClass(m)||0==a.length?!1:(s.$body.addClass(m),s.$window=e(t),s.$document=e(document),s.initialItemLoaded=!1,s.viewClosed=!1,s.items=a,s.options=e.extend(!0,{},n,o),s.currentItemIndex=s.options.openAt,(s.currentItemIndex<0||s.currentItemIndex>=a.length)&&(s.currentItemIndex=0),s.images={},!0)},P=function(){var t=this;t.$window.on("resize.smbLightEvent",function(){var e=t.items[t.currentItemIndex],a=t.comments?t.comments[e.id]:void 0;t.desktopVersion&&a&&a.state.open&&t.$root.width(t.$window.width()-t.$commentsModal.outerWidth(!0)),b.call(t)}),t.$document.on("keyup.smbLightEvent",function(e){switch(e.keyCode){case 37:L.call(t);break;case 39:M.call(t);break;case 27:if(t.commentsOpened)return t.closeComments(),!1;B.call(t)}return!1}),t.$root.on("click",".navigation",function(){t.$root.hasClass("initializing")||(e(this).hasClass("prev")?L.call(t):M.call(t))}).on("click",".close",function(){B.call(t)}),t.$socialButtonsTrigger.on("click",function(){if(!t.$root.hasClass("initializing")){var a=t.items[t.currentItemIndex],o=encodeURIComponent(a.socialUrl),n="",s="",i="";"string"==typeof a.title&&""!=a.title&&(i=n=a.title.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/'/g,"&#39;").replace(/</g,"&lt;").replace(/>/g,"&gt;"),i+=" "+a.socialUrl.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/'/g,"&#39;").replace(/</g,"&lt;").replace(/>/g,"&gt;"),s=encodeURIComponent(a.title));var r="";t.options.socialButtons.facebook&&(r='<div><iframe src="//www.facebook.com/plugins/like.php?href='+o+'&amp;width&amp;layout=button_count&amp;action=like&amp;show_faces=false&amp;share=false&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:21px; width: 135px;" allowTransparency="true"></iframe></div>'),t.options.socialButtons.twitter&&(r+='<div><a href="//twitter.com/share" class="twitter-share-button" data-url="'+o+'" data-text="'+i+'">Tweet</a><script type="text/javascript">twttr.widgets.load();</script></div>'),t.options.socialButtons.gplus&&(r+='<div><div class="g-plusone" data-size="medium" data-href="'+a.socialUrl+'"></div><script type="text/javascript">gapi.plusone.go();</script></div>'),t.options.socialButtons.inshare&&(r+='<div><script type="IN/Share" data-url="'+a.socialUrl+'" data-counter="right"></script><script type="text/javascript">if (IN.parse) IN.parse();</script></div>'),t.options.socialButtons.pinterest&&"image"==a.type&&(r+='<div><a href="//www.pinterest.com/pin/create/button/?url='+o+"&media="+encodeURIComponent(a.src)+"&description="+s+'" data-pin-do="buttonPin" data-pin-config="beside"><img src="//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_gray_20.png" /></a></div>'),""!=r&&(t.$socialButtonsWrapper.toggleClass("show").html(r),t.options.socialButtons.pinterest&&"image"==a.type&&e.ajax({url:"//assets.pinterest.com/js/pinit.js",dataType:"script",cache:!0}),e(this).toggleClass("show"))}})},R=function(e){var t=this,a=t.options.i18n[e];return a?a:e};a.prototype={center:function(){var e,t,a=this,o={},n=!1,s=0,i=0,r=!1,m=!1;if(a.initialItemLoaded){switch(e=a.items[a.currentItemIndex],e.type){case"image":t=a.images[e.src].stats,t.isLoaded?(s=t.width,i=t.height):(s=400,i=400);break;case"video":s=e.width,i=e.height,r=!0;break;case"audio":s=460,i=36,m=!0}o=C.call(a,s,i,r,m),n=!0}n||(o.width=a.$mainWrapper.width(),o.height=a.$mainWrapper.height(),o.left=Math.floor((a.overlayWidth-(o.width+a.main.horizontalSpace))/2),o.top=Math.floor((a.overlayHeight-(o.height+a.main.verticalSpace))/2)),a.$mainWrapper.stop(!0).css(o)},showItem:function(){var t=this;t.$imagesWrapper.removeClass(r),t.$loadingOverlay.addClass("inProgress").stop(!0).fadeTo(0,1,function(){t.$loadingOverlay.css("display","")}),t.$audioVideo.html(""),e("> .viewWrapper > div",t.$mainWrapper).removeClass(i),t.$mainWrapper.removeClass(l).removeClass(c).removeClass(p);var a=t.items[t.currentItemIndex];switch(a.type){case"image":I.call(t,a);break;case"video":w.call(t,t.currentItemIndex);break;case"audio":y.call(t,a);break;default:t.initialItemLoaded=!0}t.initialItemLoaded&&t.$root.removeClass("initializing")}},o.prototype={center:function(){var t=this,a=0;t.options.comments.permissions.show&&(a=e(">",t.$commentsModal).height()-t.$commentsTopBar.outerHeight(!0)-t.$newCommentWrapper.outerHeight(!0),0>a&&(a=0),t.$commentList.css("height",a)),t.$contentWrapper.removeClass(d).removeClass(u).css({width:t.items.length*t.overlayWidth,transform:"translate3d(-"+t.currentItemIndex*t.overlayWidth+"px, 0, 0)"}),e(">",t.$contentWrapper).width(t.overlayWidth).each(function(){var a=e(this),o=a.data("itemIndex"),n=t.items[o];if(!(a.hasClass("loading")||"image"!=n.type&&o!=t.currentItemIndex))if("image"==n.type){var s=t.images[n.src].stats;e("> img",a).css(C.call(t,s.width,s.height,!1))}else"video"==n.type?e("> div",a).css(C.call(t,n.width,n.height,!0)):"audio"==n.type&&e("> div",a).css(C.call(t,460,36,!1,!0))})},showItem:function(){var t=this,a=e("> div.item_"+t.currentItemIndex,t.$contentWrapper),o=t.currentItemIndex,n=t.items[o],i=function(){o>0&&g.call(t,k.call(t,o-1)),o<t.items.length-1&&g.call(t,k.call(t,o+1))};switch(t.$contentWrapper.removeClass(d).removeClass(u).css({transform:"translate3d(-"+o*t.overlayWidth+"px, 0, 0)"}),t.options.comments.permissions.show&&(t.$newCommentInput.val(""),t.$newCommentWrapper.removeClass("filledIn"),t.comments[n.id]||(t.comments[n.id]={state:{open:!1,commentsRequest:s.UNSET},count:n.comments.count,cache:{authors:{},comments:[]}}),t.$mainCommentsCount.text(t.comments[n.id].count),t.desktopVersion&&(e.each(t.comments,function(){this.state.open=!1}),t.updateItemComments())),t.options.like.permissions.liking&&(t.$likeTrigger.toggleClass("liked",n.likes.likedByUser),t.$mainLikeCount.text(n.likes.numOfLikes)),n.type){case"image":if(a.data(h))return;g.call(t,o,function(){t.currentItemIndex==o&&(t.initialItemLoaded=!0,i())}),a.data(h,!0);break;case"video":w.call(t,t.currentItemIndex);break;case"audio":y.call(t,n);break;default:t.initialItemLoaded=!0}"image"!=n.type&&i(),t.$root.removeClass("initializing")},updateItemComments:function(){var t=this,a=t.currentItemIndex,o=t.items[a],n=t.comments[o.id];n.state.open||t.$root.hasClass("initializing")||(n.state.open=!0,n.state.commentsRequest==s.UNSET?(n.state.commentsRequest=s.SENT,t.$commentsModal.addClass("loading"),e.ajax({data:{action:"list_comments"},dataType:"json",type:"GET",url:o.comments.backend,timeout:15e3,cache:!1,error:function(){n.state.commentsRequest=s.UNSET},success:function(e){n.cache=e,n.count=e.comments.length,n.state.commentsRequest=s.DONE},complete:function(){n.state.open&&a==t.currentItemIndex&&(t.$commentsModal.removeClass("loading"),S.call(t))}})):(S.call(t),t.$commentsModal.removeClass("loading")),t.$internalCommentsCount.text(n.count),t.$commentsLikes.text(o.likes.numOfLikes).toggleClass("liked",o.likes.likedByUser))},closeComments:function(){var e=this,t=e.items[e.currentItemIndex],a=e.comments[t.id];a.state.open=!1,e.desktopVersion?(clearTimeout(e.commentsAnimationTimeout),e.$root.addClass("moveComments"),e.$root.css("width",""),b.call(e),e.$root.addClass("animateComments").removeClass("moveComments"),e.commentsAnimationTimeout=setTimeout(function(){e.$root.removeClass("animateComments")},300)):(e.$root.removeClass("modalActive"),e.$modalOverlay.stop(!0).animate({opacity:0},{duration:200})),e.$commentsModal.removeClass("showAnonymWindow"),e.$anonymCommentWrapper.removeClass("addingAnonComment"),e.commentsOpened=!1}},t.SmbLight_1=function(e,t){return this instanceof SmbLight_1?t.mobile?new o(e,t):new a(e,t):new SmbLight_1(e,t)}}(eds1_10,window);