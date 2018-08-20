package game.mechanics.zeppelin.popup.clip
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.IGuiClip;
   import game.view.gui.components.ClipLabel;
   import starling.core.Starling;
   
   public class ZeppelinPopupSubscriptionButton extends ZeppelinPopupButton
   {
       
      
      private var _activeSubscription:Boolean;
      
      public var anim_blessing:GuiAnimation;
      
      public var anim_gift:GuiAnimation;
      
      public var anim_idle:ZeppelinPopupSubscriptionButtonIdle;
      
      public var tf_desc:ClipLabel;
      
      private var _idleHoverDirection:int = 1;
      
      private var _idleAnimationSpeed:Number = 1;
      
      public function ZeppelinPopupSubscriptionButton()
      {
         anim_blessing = new GuiAnimation();
         anim_gift = new GuiAnimation();
         anim_idle = new ZeppelinPopupSubscriptionButtonIdle();
         tf_desc = new ClipLabel();
         super();
      }
      
      override protected function handler_disposed() : void
      {
         super.handler_disposed();
         anim_idle.dispose();
      }
      
      public function get idleAnimationSpeed() : Number
      {
         return _idleAnimationSpeed;
      }
      
      public function set idleAnimationSpeed(param1:Number) : void
      {
         _idleAnimationSpeed = param1;
         anim_idle.playback.playbackSpeed = 1 + _idleHoverDirection * (Math.sqrt(param1) * 5);
         anim_idle.wings.playbackSpeed = 1 + Math.sqrt(param1) * 8;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            _idleHoverDirection = anim_idle.playback.currentFrame < 40 && anim_idle.playback.currentFrame > 240?-1:1;
            Starling.juggler.tween(this,0.25,{"idleAnimationSpeed":1});
            Starling.juggler.tween(this,0.5,{
               "idleAnimationSpeed":0,
               "delay":0.25
            });
         }
         super.setupState(param1,param2);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         setAnimState(anim_idle);
      }
      
      public function action_setActiveSubscription(param1:Boolean) : void
      {
         this._activeSubscription = param1;
         updateDesc();
      }
      
      override protected function handler_markerStateUpdate() : void
      {
         super.handler_markerStateUpdate();
         if(_redMarkerState && _redMarkerState.value)
         {
            setAnimState(anim_gift);
         }
         else
         {
            setAnimState(anim_idle);
         }
         updateDesc();
      }
      
      protected function updateDesc() : void
      {
         if(_redMarkerState && _redMarkerState.value)
         {
            tf_desc.text = Translate.translate("UI_BUTTON_SUBSCRIPTION_TF_STATE_COLLECT_GIFT");
         }
         else if(_activeSubscription)
         {
            tf_desc.text = Translate.translate("UI_BUTTON_SUBSCRIPTION_TF_STATE_ACTIVE");
         }
         else
         {
            tf_desc.text = Translate.translate("UI_BUTTON_SUBSCRIPTION_TF_STATE_NOT_ACTIVE");
         }
      }
      
      protected function setAnimState(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Array = [anim_blessing,anim_gift,anim_idle];
         var _loc3_:int = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc5_[_loc4_];
            _loc2_.graphics.visible = _loc2_ == param1;
            if(_loc2_ == param1)
            {
               if(_loc2_ is GuiAnimation)
               {
                  (_loc2_ as GuiAnimation).gotoAndPlay(1);
               }
               else if(_loc2_ is ClipAnimatedContainer)
               {
                  (_loc2_ as ClipAnimatedContainer).playback.gotoAndPlay(1);
               }
            }
            else if(_loc2_ is GuiAnimation)
            {
               (_loc2_ as GuiAnimation).stop();
            }
            else if(_loc2_ is ClipAnimatedContainer)
            {
               (_loc2_ as ClipAnimatedContainer).playback.stop();
            }
            _loc4_++;
         }
      }
   }
}
