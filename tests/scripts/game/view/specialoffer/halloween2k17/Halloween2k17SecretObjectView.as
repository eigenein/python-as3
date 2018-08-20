package game.view.specialoffer.halloween2k17
{
   import com.progrestar.common.error.ClientErrorManager;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.model.user.specialoffer.Halloween2k17SpecialOfferViewOwner;
   import game.model.user.specialoffer.PlayerSpecialOfferHalloween2k17secretReward;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GameLabel;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   
   public class Halloween2k17SecretObjectView extends GuiClipNestedContainer
   {
       
      
      private var offer:PlayerSpecialOfferHalloween2k17secretReward;
      
      private var _owner:Halloween2k17SpecialOfferViewOwner;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      private var _signal_click:Signal;
      
      public var anim_button:ClipButton;
      
      public var label:GameLabel;
      
      public function Halloween2k17SecretObjectView(param1:PlayerSpecialOfferHalloween2k17secretReward, param2:Halloween2k17SpecialOfferViewOwner)
      {
         _signal_click = new Signal(Halloween2k17SecretObjectView);
         anim_button = new ClipButton();
         label = new GameLabel();
         super();
         this._owner = param2;
         this.offer = param1;
         var _loc3_:RelativeAlignment = new RelativeAlignment();
         displayStyle.setOverlay(graphics,_loc3_);
         displayStyle.signal_dispose.add(dispose);
         param1.signal_removed.add(handler_removed);
         try
         {
            var _loc5_:* = param2.ident;
            if("worldmap6" !== _loc5_)
            {
               if("worldmap" !== _loc5_)
               {
                  if("artifactChest" !== _loc5_)
                  {
                     if("tower50" !== _loc5_)
                     {
                        if("zeppelin" !== _loc5_)
                        {
                           if("moon" !== _loc5_)
                           {
                              AssetStorage.rsx.main_screen.initGuiClip(anim_button,"expeditions_animation_idle");
                           }
                           else
                           {
                              AssetStorage.rsx.main_screen.initGuiClip(anim_button,"hidden_moon_button");
                           }
                        }
                        else
                        {
                           AssetStorage.rsx.main_screen.initGuiClip(anim_button,"secret_candles3_animation");
                        }
                     }
                     else
                     {
                        AssetStorage.rsx.main_screen.initGuiClip(anim_button,"candles3_animation");
                     }
                  }
                  else
                  {
                     AssetStorage.rsx.main_screen.initGuiClip(anim_button,"hidden_web");
                  }
               }
               else
               {
                  AssetStorage.rsx.main_screen.initGuiClip(anim_button,"candle_map");
               }
            }
            else
            {
               AssetStorage.rsx.main_screen.initGuiClip(anim_button,"secret_cauldron");
            }
         }
         catch(error:Error)
         {
            ClientErrorManager.action_handleError(error);
         }
         container.addChild(anim_button.graphics);
         anim_button.signal_click.add(handler_click);
         label = GameLabel.size26();
         container.addChild(label);
      }
      
      public function dispose() : void
      {
         displayStyle.signal_dispose.remove(dispose);
         offer.signal_removed.remove(handler_removed);
      }
      
      public function get owner() : Halloween2k17SpecialOfferViewOwner
      {
         return _owner;
      }
      
      public function get signal_click() : Signal
      {
         return _signal_click;
      }
      
      public function hide(param1:int, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         label.text = param1 + "/" + param2;
         anim_button.graphics.visible = false;
         try
         {
            label.validate();
            _loc4_ = anim_button.graphics.getBounds(anim_button.graphics.parent);
            label.x = label.x + (_loc4_.x + _loc4_.width * 0.5 - label.width * 0.5);
            label.y = label.y + (_loc4_.y + _loc4_.height * 0.5 - label.height * 0.5);
            _loc3_ = graphics.globalToLocal(new Point(500,320));
            Starling.juggler.tween(label,3,{
               "x":label.x * 0.5 + _loc3_.x * 0.5,
               "y":label.y * 0.5 + _loc3_.y * 0.5,
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
