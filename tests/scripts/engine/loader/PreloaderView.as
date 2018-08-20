package engine.loader
{
   import com.progrestar.common.loader.LoaderAppFriendListBase;
   import com.progrestar.common.social.SocialAdapter;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class PreloaderView extends Sprite
   {
       
      
      protected var preloader:MovieClip;
      
      protected var loaderBitmap:BitmapData;
      
      protected var stat:Function;
      
      protected var preloaderBar:MovieClip;
      
      protected var errorDisplay:MovieClip;
      
      protected var percentTextField:TextField;
      
      protected var preloaderContainer:Sprite;
      
      protected var graphicContainer:Sprite;
      
      protected var fast_loading_btn:SimpleButton;
      
      protected var first_loading_reward:MovieClip;
      
      private var viewMc:MovieClip;
      
      public function PreloaderView(param1:Function, param2:MovieClip)
      {
         super();
         this.viewMc = param2;
         this.stat = param1;
         createLoaderMovieClip();
         addEventListener("addedToStage",addedToStageHandler);
         addEventListener("removedFromStage",removedFromStageHandler);
         if(preloader)
         {
            preloaderContainer = new Sprite();
            graphicContainer = new Sprite();
            preloaderContainer.addChild(graphicContainer);
            preloaderContainer.addChild(preloader);
            addChild(preloaderContainer);
         }
      }
      
      public function update(param1:int) : void
      {
         if(percentTextField)
         {
            percentTextField.text = param1.toString() + "%";
         }
         if(preloaderBar)
         {
            preloaderBar.gotoAndStop(param1);
         }
      }
      
      public function displayError(param1:String) : void
      {
         var _loc2_:* = null;
         if(errorDisplay != null && errorDisplay.parent != null && errorDisplay.parent.numChildren != 0)
         {
            _loc2_ = errorDisplay.getChildByName("desc") as TextField;
            if(_loc2_)
            {
               _loc2_.text = param1;
            }
            errorDisplay.parent.setChildIndex(errorDisplay,errorDisplay.parent.numChildren - 1);
         }
      }
      
      protected function createLoaderMovieClip() : void
      {
         preloader = viewMc;
         addChild(preloader);
         preloaderBar = preloader.getChildByName("progress") as MovieClip;
         errorDisplay = preloader.getChildByName("errorDisplay") as MovieClip;
         if(preloaderBar)
         {
            preloaderBar.stop();
            percentTextField = preloader.getChildByName("txt") as TextField;
            if(percentTextField)
            {
               percentTextField.text = "0";
            }
            fast_loading_btn = preloader.getChildByName("fastBtn") as SimpleButton;
            if(fast_loading_btn)
            {
               fast_loading_btn.addEventListener("click",fastLoadClick);
            }
            first_loading_reward = preloader.getChildByName("firstLoadBlock") as MovieClip;
            first_loading_reward.visible = false;
            createLoaderAppfriendList(preloader.getChildByName("appfriendlist") as MovieClip,first_loading_reward);
         }
         else if(preloader)
         {
            preloader.x = 0;
            preloader.y = 0;
            var _loc1_:Boolean = false;
            preloader.mouseChildren = _loc1_;
            preloader.mouseEnabled = _loc1_;
         }
      }
      
      protected function fastLoadClick(param1:MouseEvent) : void
      {
         if(SocialAdapter.instance.PERMISSION_BOOKMARK_MASK != 0 && !SocialAdapter.instance.PERMISSION_BOOKMARK)
         {
            SocialAdapter.instance.showSettingsBox(SocialAdapter.instance.PERMISSION_BOOKMARK_MASK);
            stat && stat("INVITE_STAT","SPEED_UP_BUTTON");
         }
         else
         {
            inviteFriends();
         }
      }
      
      protected function inviteFriends() : void
      {
         stat && stat("INVITE_STAT","PRELOADER_SHOW_INVITE_BOX");
         SocialAdapter.instance.showInviteBox();
      }
      
      protected function removedFromStageHandler(param1:Event) : void
      {
         stage.removeEventListener("resize",positionPreloader);
      }
      
      protected function addedToStageHandler(param1:Event) : void
      {
         stage.addEventListener("resize",positionPreloader);
         stage.scaleMode = "noScale";
         positionPreloader();
      }
      
      protected function createLoaderAppfriendList(param1:MovieClip, param2:MovieClip) : void
      {
      }
      
      protected function getStageRect(param1:Stage, param2:DisplayObject) : Rectangle
      {
         var _loc4_:int = param1.stageWidth;
         var _loc5_:int = param1.stageHeight;
         var _loc6_:Point = param2.localToGlobal(new Point(0,0));
         var _loc3_:Rectangle = new Rectangle(0,0,_loc4_,_loc5_);
         _loc3_.offset(-_loc6_.x,-_loc6_.y);
         return _loc3_;
      }
      
      protected function positionPreloader(param1:Event = null) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         if(preloader)
         {
            _loc2_ = getStageRect(stage,preloaderContainer);
            _loc4_ = new Rectangle(0,0,760,690);
            _loc3_ = (_loc2_.width - _loc4_.width) / 2;
            preloader.x = _loc3_;
            if(loaderBitmap)
            {
               graphicContainer.graphics.clear();
               graphicContainer.graphics.beginBitmapFill(loaderBitmap,null,true,false);
               graphicContainer.graphics.drawRect(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
            }
         }
      }
      
      protected function stopChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = param1.numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.getChildAt(_loc4_) as MovieClip;
            if(_loc2_)
            {
               stopChildren(_loc2_);
               _loc2_.stop();
            }
            _loc4_++;
         }
      }
   }
}
