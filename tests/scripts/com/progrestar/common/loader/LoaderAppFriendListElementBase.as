package com.progrestar.common.loader
{
   import com.progrestar.common.social.SocialUser;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class LoaderAppFriendListElementBase
   {
       
      
      protected var mc:MovieClip;
      
      private var pictureContainer:MovieClip;
      
      private var user:SocialUser;
      
      public function LoaderAppFriendListElementBase(param1:MovieClip)
      {
         super();
         this.mc = param1;
         param1.addEventListener("removedFromStage",stopTicking);
      }
      
      public function loadUserPhoto(param1:SocialUser) : void
      {
         this.user = param1;
         if(param1 && mc)
         {
            mc.addEventListener("enterFrame",tick);
         }
         else if(mc)
         {
            mc.visible = false;
         }
      }
      
      public function tick(param1:Event) : void
      {
         if(user && user.mediumPhoto)
         {
            placePhoto();
            stopTicking(null);
         }
      }
      
      private function stopTicking(param1:Event) : void
      {
         if(mc)
         {
            mc.removeEventListener("enterFrame",tick);
         }
      }
      
      protected function placePhoto() : void
      {
         var _loc1_:MovieClip = mc.getChildByName("maskedContainer") as MovieClip;
         if(_loc1_)
         {
            pictureContainer = _loc1_.getChildByName("pictureContainer") as MovieClip;
            addAndResize(user.mediumPhoto,pictureContainer);
         }
      }
      
      protected function addAndResize(param1:DisplayObject, param2:DisplayObjectContainer, param3:Number = 1.05) : void
      {
         var _loc4_:Number = param2.width / param1.width;
         var _loc6_:Number = param2.height / param1.height;
         var _loc7_:Number = Math.max(_loc4_,_loc6_);
         param1.scaleX = param1.scaleX * (_loc4_ > 0?param3 * _loc7_:Number(-param3 * _loc7_));
         param1.scaleY = param1.scaleY * (param3 * _loc7_);
         param1.scaleX = param1.scaleX / param2.scaleX;
         param1.scaleY = param1.scaleY / param2.scaleY;
         var _loc8_:Rectangle = param2.getBounds(param2);
         var _loc9_:int = 0;
         param1.y = _loc9_;
         param1.x = _loc9_;
         param2.addChild(param1);
         var _loc5_:Rectangle = param1.getBounds(param2);
         param1.x = (_loc8_.width - _loc5_.width) / 2 - _loc5_.x + _loc8_.x;
         param1.y = (_loc8_.height - _loc5_.height) / 2 - _loc5_.y + _loc8_.y;
      }
   }
}
