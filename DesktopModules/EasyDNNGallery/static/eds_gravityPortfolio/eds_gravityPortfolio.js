!function(e,t,i){"use strict";function o(i,o){var s=this;s.options=o,s.itemCache={},s.$moduleWrapper=e(i),s.$contentWrapper=e(".edsgg__itemsListContainer",s.$moduleWrapper),s.$header=e(".edg__gravityPortfolio_header",s.$moduleWrapper),s.$headerTitle=e(".edg__gravityPortfolio_title",s.$header),s.$visibleItemList=e(".edg__gravityPortfolio_visibleItemList",s.$moduleWrapper),s.$hiddenItemWrapper=e(".edg__gravityPortfolio_hiddenItemWrapper",s.$moduleWrapper),s.$hiddenItemList=e(".edg__gravityPortfolio_hiddenItemList",s.$hiddenItemWrapper),s.itemCount=e(">",s.$visibleItemList).length,s.activeItemIndex=e("> ."+r,s.$visibleItemList).index(),s.verticalLayout=!1,s.verticalLayout&&(s.$heightReference=e(".edg__gravityPortfolio_heightReference",s.$moduleWrapper));var d="click fakeClick";s.options.loadContentOnHover&&(d+=" mouseenter"),s.$moduleWrapper.on("click",".edg__gravityPortfolio_hiddenItemWrapper .edg__gravityPortfolio_hiddenItemList >",function(){var t=e(this);t.addClass(r).siblings().removeClass(r),e("> ."+a,s.$visibleItemList).eq(t.index()).trigger("fakeClick")}).on(d,".edg__gravityPortfolio_visibleItemList >",function(){var t=e(this);t.addClass(r).siblings().removeClass(r),s.activeItemIndex=t.index(),s.$moduleWrapper.removeClass(v+" "+p),h.call(s,t.data("meta").contentKey,1)}).on("click",".edg__gravityPortfolio_previousPage, .edg__gravityPortfolio_nextPage",function(){var t=e(this),i=!1;if(!t.hasClass("edg__gravityPortfolio_previousPage")||!s.$moduleWrapper.hasClass(u)){if(t.hasClass("edg__gravityPortfolio_nextPage")){if(s.$moduleWrapper.hasClass(g))return;i=!0,s.$moduleWrapper.addClass(v).removeClass(p)}else s.$moduleWrapper.addClass(p).removeClass(v);var o="-1",a=e(">",s.$visibleItemList);a.length&&(o=a.eq(s.activeItemIndex).data("meta").contentKey);var r=s.itemCache[o],d=1;if(r){if(r.totalItemCount<=0)return;d=r.activePage}i?d++:d--,h.call(s,o,d)}}),s.itemCache[-1]={pages:{1:{content:s.$contentWrapper[0].outerHTML,loaded:!0,requesting:!1,requestError:!1}},totalItemCount:o.initialContentItemCount,activePage:1},s.resize(),_.call(s),C.call(s),s.$moduleWrapper.addClass("edg__gravityPortfolio_ready"),e(t).on("resize",function(){s.resize()})}var a="edg__gravityPortfolio_hide",r="edg__gravityPortfolio_active",s="edg__gravityPortfolio_itemsHidden",d="edg__gravityPortfolio_pageReady",l="edg__gravityPortfolio_loading",n="edg__gravityPortfolio_noContent",m="edg__gravityPortfolio_contentError",u="edg__gravityPortfolio_disablePreviousPage",g="edg__gravityPortfolio_disableNextPage",p="edg__gravityPortfolio_triggeredPreviousPage",v="edg__gravityPortfolio_triggeredNextPage",_=function(){var e=this;e.options.masonry&&e.$contentWrapper.isotope({itemSelector:".edsgg__itemContainer",sortBy:"original-order",masonry:{isFitWidth:!0}}).find("img").imagesLoaded().progress(function(){e.$contentWrapper.isotope("layout")})},c=function(){var t=this;t.verticalLayout&&t.resize(),e(".edsgg__galleryReInitM"+t.options.moduleId,t.$mainWrapper).click()},f=function(t,i){var o=this,a=e(">",o.$visibleItemList).eq(o.activeItemIndex);if(!(a.length>0&&a.data("meta").contentKey!=t)){var r=o.itemCache[t],s=r.pages[i+""];if(r.activePage==i)return o.$moduleWrapper.removeClass(d).removeClass(l).removeClass(n).removeClass(m).removeClass(u).removeClass(g),clearTimeout(o.pageReadyTimeout),o.pageReadyTimeout=setTimeout(function(){o.$moduleWrapper.addClass(d)},100),e(".edsgg__galleryReInitM"+o.options.moduleId,o.$moduleWrapper).data("galleryid",t),0==r.totalItemCount||-1==r.totalItemCount?(o.$moduleWrapper.addClass(n),void c.call(o)):-1==r.totalItemCount||!s.loaded&&s.requestError?(o.$moduleWrapper.addClass(m),void c.call(o)):void(s.loaded&&(1==i&&o.$moduleWrapper.addClass(u),Math.ceil(r.totalItemCount/o.options.itemsPerPage)<=i&&o.$moduleWrapper.addClass(g),o.$contentWrapper.replaceWith(s.content),o.$contentWrapper=e(".edsgg__itemsListContainer",o.$moduleWrapper),_.call(o),C.call(o),c.call(o)))}},h=function(t,i){var o,a=this,r=a.itemCache[t];if(r||(r={pages:{},totalItemCount:-1,activePage:-1},a.itemCache[t]=r),1>i&&(i=1),-1!=r.totalItemCount){var s=Math.ceil(r.totalItemCount/a.options.itemsPerPage);i>s&&(i=s)}if(r.activePage=i,0==r.totalItemCount)return void f.call(a,t,i);var d=i+"";if(o=r.pages[d]){if(o.loaded)return void f.call(a,t,i);if(o.requesting)return void a.$moduleWrapper.addClass(l)}else r.pages[d]=o={content:"",loaded:!1,requesting:!0,requestError:!1};-1==r.totalItemCount&&a.$moduleWrapper.addClass(u+" "+g),a.$moduleWrapper.addClass(l),o.requesting=!0;var n=!1,m=-1==r.totalItemCount,p={portalId:a.options.portalId,moduleId:a.options.moduleId,emodule:a.options.moduleId,tabId:a.options.tabId,egallery:t,eitem:a.options.eitem,page:i,getPaginationMeta:m};a.options.userId?p.userId=a.options.userId:a.options.groupId&&(p.groupId=a.options.groupId),e.ajax({type:"GET",url:a.options.websiteClientRoot+"DesktopModules/EasyDNNGallery/Services/LoadMediaHtmlData.ashx",cache:!1,dataType:"json",timeout:15e3,data:p}).done(function(t,i){if(n=!0,"nocontent"==i||!e.isPlainObject(t))return r.totalItemCount=0,void(o.loaded=!0);if(m){if(!t.total)return void(n=!1);r.totalItemCount=t.total}o.content=t.itemsHtml,o.loaded=!0}).always(function(){o.requesting=!1,o.requestError=!n,f.call(a,t,i)})},C=function(){function t(e,t){var i,o,a;return a=e.width(),o=e.height(),i={distLeft:t.offsetX,distRight:a-t.offsetX,distTop:t.offsetY,distBottom:o-t.offsetY}}var i=this;if(i.options.overlay){var o;if(o=e(".edGP__mousePosition"),o.length>0){var a="edGP__inLeft edGP__inRight edGP__inTop edGP__inBottom edGP__outLeft edGP__outRight edGP__outTop edGP__outBottom";o.on("mouseenter",function(i){var o=e(this),r=t(o,i),s=Math.min(r.distLeft,r.distRight,r.distTop,r.distBottom);switch(s){case r.distLeft:return o.removeClass(a).addClass("edGP__inLeft");case r.distRight:return o.removeClass(a).addClass("edGP__inRight");case r.distTop:return o.removeClass(a).addClass("edGP__inTop");case r.distBottom:return o.removeClass(a).addClass("edGP__inBottom")}}),o.on("mouseleave",function(i){var o=e(this),r=t(o,i),s=Math.min(r.distLeft,r.distRight,r.distTop,r.distBottom);switch(s){case r.distLeft:return o.removeClass(a).addClass("edGP__outLeft");case r.distRight:return o.removeClass(a).addClass("edGP__outRight");case r.distTop:return o.removeClass(a).addClass("edGP__outTop");case r.distBottom:return o.removeClass(a).addClass("edGP__outBottom")}})}}};o.prototype={resize:function(t){var i=this,o=!1;if(e(">",i.$visibleItemList).removeClass(a),i.verticalLayout){if(0==i.$heightReference.length)return;var r=i.$heightReference.outerHeight(!0);if(i.$visibleItemList.outerHeight(!0)>r){o=!0;var d=i.itemCount-1;for(i.$hiddenItemList.empty();d>=0&&i.$visibleItemList.outerHeight(!0)>r;){var l=e(">",i.$visibleItemList).eq(d);l.addClass(a),i.$hiddenItemList.prepend(l.clone(!0)),d--}}clearTimeout(i.reResizeTimeout),t||(i.reResizeTimeout=setTimeout(function(){i.resize(!0)},1e3))}else{var n=i.$header.innerWidth()-(0==i.$headerTitle.length?0:i.$headerTitle.outerWidth(!0))-20;if(i.$visibleItemList.outerWidth(!1)>n){o=!0;var d=i.itemCount-1;for(i.$hiddenItemList.empty();d>=0&&i.$visibleItemList.outerWidth(!1)>n;){var l=e(">",i.$visibleItemList).eq(d);l.addClass(a),i.$hiddenItemList.prepend(l.clone(!0)),d--}}}o?(i.$visibleItemList.addClass(s),i.$hiddenItemWrapper.addClass(s)):(i.$visibleItemList.removeClass(s),i.$hiddenItemWrapper.removeClass(s))}};var I="edsGravityPortfolio",P={websiteClientRoot:"/",portalId:0,moduleId:0,tabId:0,itemsPerPage:5,eitem:0,loadContentOnHover:!0,initialContentItemCount:0,masonry:!1,overlay:!1};e.fn.edsGravityPortfolio=function(t){return t=e.extend({},P,t),this.each(function(){var i=e(this);i.data(I)||i.data(I,new o(this,t))})}}(eds1_10,window);