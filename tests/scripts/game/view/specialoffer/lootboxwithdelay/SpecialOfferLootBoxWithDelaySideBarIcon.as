package game.view.specialoffer.lootboxwithdelay
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferLootBoxWithDelay;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.overlay.offer.SpecialOfferClipButton;
   import starling.display.DisplayObject;
   import starling.filters.ColorMatrixFilter;
   
   public class SpecialOfferLootBoxWithDelaySideBarIcon extends SpecialOfferClipButton
   {
       
      
      private var timer:Timer;
      
      public var untouchable:Vector.<GuiAnimation>;
      
      public var tf_title:ClipLabel;
      
      public var tf_time:ClipLabel;
      
      public var tf_time_label:ClipLabel;
      
      public var flag_sprite:ClipSprite;
      
      public var red_marker:ClipSprite;
      
      public function SpecialOfferLootBoxWithDelaySideBarIcon()
      {
         timer = new Timer(500);
         untouchable = new Vector.<GuiAnimation>();
         tf_title = new ClipLabel();
         tf_time = new ClipLabel();
         tf_time_label = new ClipLabel();
         flag_sprite = new ClipSprite();
         red_marker = new ClipSprite();
         super();
         timer.addEventListener("timer",handler_timer);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         timer.stop();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      override public function setIcon(param1:SpecialOfferIconDescription) : void
      {
         super.setIcon(param1);
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         AssetStorage.instance.globalLoader.requestAssetWithCallback(param1.asset.asset,handler_assetLoaded);
      }
      
      protected function handler_timer(param1:TimerEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         if(icon && icon.specialOffer)
         {
            _loc4_ = icon.specialOffer as PlayerSpecialOfferLootBoxWithDelay;
            if(_loc4_)
            {
               _loc3_ = _loc4_.isReady.value;
               _loc2_ = _loc4_.isOpen.value;
               if(!_loc3_)
               {
                  tf_time_label.text = Translate.translate("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_TIMER_LABEL_SHORT");
                  tf_time.text = _loc4_.timeToOpenString;
               }
               else if(_loc4_.showEndTimeTimer)
               {
                  tf_time_label.text = Translate.translate("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_HURRY_UP");
                  tf_time.text = _loc4_.timeToEndString;
               }
               else
               {
                  tf_time_label.text = Translate.translate("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_FIND_OUT");
                  tf_time.text = "";
               }
               red_marker.graphics.visible = _loc3_;
            }
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         super.setNode(param1);
         var _loc2_:int = container.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = container.getChildAt(_loc3_);
            if(_loc4_ != layout_hitArea && _loc4_ != sizeQuad)
            {
               layout_hitArea.addChild(_loc4_);
               _loc2_--;
               _loc4_.touchable = false;
            }
            else
            {
               _loc3_++;
            }
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(flag_sprite == null || flag_sprite.graphics == null)
         {
            return;
         }
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            flag_sprite.graphics.filter = _loc3_;
         }
         else if(flag_sprite.graphics.filter)
         {
            flag_sprite.graphics.filter.dispose();
            flag_sprite.graphics.filter = null;
         }
      }
      
      private function handler_assetLoaded(param1:RsxGameAsset) : void
      {
         icon.asset.initGuiClip(this);
         if(icon && icon.specialOffer)
         {
            timer.start();
         }
         if(icon && tf_title && tf_title.graphics)
         {
            tf_title.text = Translate.translate(icon.iconLabelLocaleId);
         }
         graphics.dispatchEventWith("resize");
         graphics.dispatchEventWith("layoutDataChange");
         layout_hitArea.invalidate();
         handler_timer(null);
      }
   }
}
