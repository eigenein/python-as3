package game.view.gui.components.controller
{
   import flash.geom.Point;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class TouchButtonController
   {
      
      public static const STATE_UP:String = "up";
      
      public static const STATE_DOWN:String = "down";
      
      public static const STATE_HOVER:String = "hover";
      
      public static const STATE_DISABLED:String = "disabled";
      
      private static const HELPER_POINT:Point = new Point();
       
      
      private var hitZone:DisplayObjectContainer;
      
      private var buttonView:IButtonView;
      
      private var _isEnabled:Boolean = true;
      
      private var defaultSkin:Sprite;
      
      private var touchPointID:int = -1;
      
      protected var _currentState:String = "up";
      
      public function TouchButtonController(param1:DisplayObjectContainer, param2:IButtonView)
      {
         super();
         this.hitZone = param1;
         this.buttonView = param2;
         param1.useHandCursor = true;
         param1.addEventListener("touch",handler_touch);
         param1.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function dispose() : void
      {
         hitZone.removeEventListener("touch",handler_touch);
         hitZone.removeEventListener("removedFromStage",handler_removedFromStage);
      }
      
      protected function get currentState() : String
      {
         return this._currentState;
      }
      
      protected function set currentState(param1:String) : void
      {
         if(this._currentState == param1)
         {
            return;
         }
         this._currentState = param1;
         buttonView.setupState(_currentState,touchPointID >= 0);
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         if(this._isEnabled == param1)
         {
            return;
         }
         this._isEnabled = param1;
         if(!this._isEnabled)
         {
            hitZone.touchable = false;
            this.currentState = "disabled";
            this.touchPointID = -1;
         }
         else
         {
            if(this.currentState == "disabled")
            {
               this.currentState = "up";
            }
            hitZone.touchable = true;
         }
      }
      
      protected function handler_touch(param1:TouchEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         if(!this._isEnabled)
         {
            this.touchPointID = -1;
            return;
         }
         if(this.touchPointID >= 0)
         {
            _loc3_ = param1.getTouch(hitZone,null,this.touchPointID);
            if(!_loc3_)
            {
               return;
            }
            _loc3_.getLocation(hitZone.stage,HELPER_POINT);
            _loc2_ = hitZone.contains(hitZone.stage.hitTest(HELPER_POINT,true));
            if(_loc3_.phase == "moved")
            {
               if(_loc2_)
               {
                  this.currentState = "down";
               }
               else
               {
                  this.currentState = "up";
               }
            }
            else if(_loc3_.phase == "ended")
            {
               if(_loc2_)
               {
                  buttonView.click();
               }
               this.resetTouchState(_loc3_);
            }
            return;
         }
         _loc3_ = param1.getTouch(hitZone,"began");
         if(_loc3_)
         {
            this.touchPointID = _loc3_.id;
            this.currentState = "down";
            return;
         }
         _loc3_ = param1.getTouch(hitZone,"hover");
         if(_loc3_)
         {
            this.currentState = "hover";
            return;
         }
         this.currentState = "up";
      }
      
      protected function resetTouchState(param1:Touch = null) : void
      {
         this.touchPointID = -1;
         if(this._isEnabled)
         {
            this.currentState = "up";
         }
         else
         {
            this.currentState = "disabled";
         }
      }
      
      protected function handler_removedFromStage(param1:Event) : void
      {
         this.resetTouchState();
      }
   }
}
