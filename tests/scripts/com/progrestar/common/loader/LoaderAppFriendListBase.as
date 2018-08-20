package com.progrestar.common.loader
{
   import com.progrestar.common.social.SocialAdapter;
   import com.progrestar.common.util.CollectionUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class LoaderAppFriendListBase extends Sprite
   {
      
      public static var HIDE_AT_START:Boolean = true;
      
      private static var dataInited:Boolean;
      
      private static var viewInited:Boolean;
      
      private static var data:Array;
      
      private static var _instance:LoaderAppFriendListBase;
       
      
      private var mc:MovieClip;
      
      private var panels:Array;
      
      public function LoaderAppFriendListBase(param1:MovieClip, param2:RegExp = null)
      {
         super();
         param2 = param2 || /element\d+/i;
         _instance = this;
         this.mc = param1;
         _initView(param2);
      }
      
      public static function get instance() : LoaderAppFriendListBase
      {
         return _instance;
      }
      
      public static function initData() : void
      {
         var _loc1_:Array = SocialAdapter.instance.getAppFriendsList();
         _loc1_ = CollectionUtil.shuffleArray(_loc1_.slice());
         data = _loc1_.slice(0,10);
         dataInited = true;
         checkInit();
      }
      
      private static function checkInit() : void
      {
         if(dataInited && viewInited)
         {
            instance.render();
         }
      }
      
      protected function createElement(param1:MovieClip) : LoaderAppFriendListElementBase
      {
         return new LoaderAppFriendListElementBase(param1);
      }
      
      protected function render() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(panels && panels.length)
         {
            if(mc != null)
            {
               if(HIDE_AT_START)
               {
                  mc.visible = data.length != 0;
               }
            }
            _loc2_ = panels.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = panels[_loc3_];
               _loc1_.loadUserPhoto(data[_loc3_]);
               _loc3_++;
            }
            moveLabel();
         }
      }
      
      private function _initView(param1:RegExp) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         panels = [];
         if(mc)
         {
            _loc2_ = mc.numChildren;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = mc.getChildAt(_loc3_) as MovieClip;
               if(_loc5_ && param1.test(_loc5_.name))
               {
                  _loc4_ = createElement(_loc5_);
                  panels.push(_loc4_);
               }
               _loc3_++;
            }
            if(HIDE_AT_START)
            {
               mc.visible = false;
            }
         }
         viewInited = true;
         checkInit();
      }
      
      public function moveLabel() : void
      {
      }
   }
}
