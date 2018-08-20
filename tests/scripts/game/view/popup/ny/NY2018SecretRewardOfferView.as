package game.view.popup.ny
{
   import com.progrestar.common.error.ClientErrorManager;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.model.user.specialoffer.NY2018SecretRewardOffer;
   import game.model.user.specialoffer.NY2018SecretRewardOfferViewOwner;
   import game.view.gui.components.ClipButton;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   
   public class NY2018SecretRewardOfferView extends GuiClipNestedContainer
   {
       
      
      private var offer:NY2018SecretRewardOffer;
      
      private var _owner:NY2018SecretRewardOfferViewOwner;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      private var _signal_click:Signal;
      
      public var anim_button:ClipButton;
      
      public var keypad:NY2018SecretRewardOfferViewKeypad;
      
      public var label:ClipSprite;
      
      public function NY2018SecretRewardOfferView(param1:NY2018SecretRewardOffer, param2:NY2018SecretRewardOfferViewOwner)
      {
         _signal_click = new Signal(NY2018SecretRewardOfferView);
         anim_button = new ClipButton();
         keypad = new NY2018SecretRewardOfferViewKeypad();
         label = new ClipSprite();
         super();
         this._owner = param2;
         this.offer = param1;
         var _loc5_:RelativeAlignment = new RelativeAlignment();
         displayStyle.setOverlay(graphics,_loc5_);
         displayStyle.signal_dispose.add(dispose);
         param1.signal_removed.add(handler_removed);
         var _loc3_:Boolean = false;
         try
         {
            var _loc7_:* = param2.ident;
            if("key_1" !== _loc7_)
            {
               if("key_2" !== _loc7_)
               {
                  if("key_3" !== _loc7_)
                  {
                     if("tree" !== _loc7_)
                     {
                        if("moon" !== _loc7_)
                        {
                           if("fireworks" !== _loc7_)
                           {
                              AssetStorage.rsx.main_screen.initGuiClip(anim_button,"gift3_animation");
                           }
                           else
                           {
                              AssetStorage.rsx.main_screen.initGuiClip(anim_button,"secret_fireworks_jingle");
                           }
                        }
                        else
                        {
                           AssetStorage.rsx.main_screen.initGuiClip(anim_button,"santa_giftDrop_animation_button");
                        }
                     }
                     else
                     {
                        _loc3_ = true;
                        AssetStorage.rsx.main_screen.initGuiClip(keypad,"letters_keypad");
                     }
                  }
               }
               addr60:
               AssetStorage.rsx.main_screen.initGuiClip(anim_button,"secretReward_gift_1");
            }
            §§goto(addr60);
         }
         catch(error:Error)
         {
            ClientErrorManager.action_handleError(error);
         }
         if(_loc3_)
         {
            container.addChild(keypad.graphics);
            anim_button.signal_click.add(handler_click);
            keypad.setData(param1.getKeyList());
            keypad.signal_click.add(handler_click);
         }
         else
         {
            container.addChild(anim_button.graphics);
            anim_button.signal_click.add(handler_click);
         }
         var _loc4_:String = param1.getKeyIndex(param2.ident);
         AssetStorage.rsx.main_screen.initGuiClip(label,_loc4_);
      }
      
      public function dispose() : void
      {
         displayStyle.signal_dispose.remove(dispose);
         offer.signal_removed.remove(handler_removed);
      }
      
      public function get signal_click() : Signal
      {
         return _signal_click;
      }
      
      public function get owner() : NY2018SecretRewardOfferViewOwner
      {
         return _owner;
      }
      
      public function hide(param1:int, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         anim_button.graphics.visible = false;
         try
         {
            _loc4_ = anim_button.graphics.getBounds(anim_button.graphics.parent);
            label.graphics.x = label.graphics.x + (_loc4_.x + _loc4_.width * 0.5 - label.graphics.width * 0.5);
            label.graphics.y = label.graphics.y + (_loc4_.y + _loc4_.height * 0.5 - label.graphics.height * 0.5);
            container.addChild(label.graphics);
            _loc3_ = graphics.globalToLocal(new Point(500,320));
            Starling.juggler.tween(label.graphics,3,{
               "x":label.graphics.x * 0.5 + _loc3_.x * 0.5,
               "y":label.graphics.y * 0.5 + _loc3_.y * 0.5,
               "alpha":0
            });
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
      
      private function handler_removed() : void
      {
         displayStyle.dispose();
      }
      
      private function handler_click() : void
      {
         _signal_click.dispatch(this);
      }
   }
}
