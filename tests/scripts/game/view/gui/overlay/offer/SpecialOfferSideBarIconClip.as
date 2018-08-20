package game.view.gui.overlay.offer
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.context.GameContext;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.view.gui.components.ClipLabel;
   import starling.display.DisplayObject;
   import starling.filters.ColorMatrixFilter;
   
   public class SpecialOfferSideBarIconClip extends SpecialOfferClipButton
   {
       
      
      private var timer:Timer;
      
      public var icon_tmp:GuiAnimation;
      
      public var text:BundleButtonTextBlockClip;
      
      public var animation_back:GuiAnimation;
      
      public var animation_front:GuiAnimation;
      
      public var animation_hover:GuiAnimation;
      
      public var tf_single_line:ClipLabel;
      
      public var tf_time:ClipLabel;
      
      public var flag_sprite:ClipSprite;
      
      public var red_marker:ClipSprite;
      
      public function SpecialOfferSideBarIconClip()
      {
         timer = new Timer(500);
         icon_tmp = new GuiAnimation();
         text = new BundleButtonTextBlockClip();
         animation_back = new GuiAnimation();
         animation_front = new GuiAnimation();
         animation_hover = new GuiAnimation();
         tf_single_line = new ClipLabel();
         tf_time = new ClipLabel();
         flag_sprite = new ClipSprite();
         red_marker = new ClipSprite();
         super();
         timer.addEventListener("timer",handler_timer);
      }
      
      override public function dispose() : void
      {
         timer.stop();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      override public function setIcon(param1:SpecialOfferIconDescription) : void
      {
         super.setIcon(param1);
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         AssetStorage.instance.globalLoader.requestAssetWithCallback(param1.asset.asset,handler_assetLoaded);
         handler_timer(null);
      }
      
      protected function handler_timer(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         if(icon && icon.specialOffer)
         {
            _loc2_ = icon.specialOffer as PlayerSpecialOfferWithTimer;
            if(_loc2_)
            {
               updateTime(_loc2_.timerStringDHorHMS);
               red_marker.graphics.visible = _loc2_.redMarkerVisible;
            }
         }
      }
      
      public function updateTime(param1:String) : void
      {
         if(animation_back.isCreated)
         {
            text.tf_time.text = param1;
         }
         else
         {
            tf_time.text = param1;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         super.setNode(param1);
         layout_hitArea.graphics.touchable = false;
         if(animation_back.isCreated)
         {
            if(GameContext.instance.localeID == "en")
            {
               if(text.tf_single_line_14.width != 0)
               {
                  text.tf_single_line_14.text = Translate.translate(icon.iconLabelLocaleId);
                  text.tf_single_line_14.adjustSizeToFitWidth();
                  text.tf_txt_line_1.visible = false;
                  text.tf_single_line_14.visible = true;
               }
               else if(text.tf_txt_line_1.width != 0)
               {
                  text.tf_txt_line_1.text = Translate.translate(icon.iconLabelLocaleId);
                  text.tf_txt_line_1.visible = true;
                  text.tf_single_line_14.visible = false;
               }
               text.tf_txt_line_2.visible = false;
               text.tf_single_line.visible = false;
            }
            else
            {
               if(text.tf_single_line.width != 0)
               {
                  text.tf_single_line.text = Translate.translate(icon.iconLabelLocaleId);
                  text.tf_single_line.adjustSizeToFitWidth();
                  text.tf_txt_line_1.visible = false;
                  text.tf_single_line.visible = true;
               }
               else if(text.tf_txt_line_1.width != 0)
               {
                  text.tf_txt_line_1.text = Translate.translate(icon.iconLabelLocaleId);
                  text.tf_txt_line_1.visible = true;
                  text.tf_single_line.visible = false;
               }
               text.tf_txt_line_2.visible = false;
               text.tf_single_line_14.visible = false;
            }
         }
         else if(icon)
         {
            tf_single_line.text = Translate.translate(icon.iconLabelLocaleId);
         }
         var _loc2_:int = container.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = container.getChildAt(_loc3_);
            if(_loc4_ != layout_hitArea && _loc4_ != sizeQuad)
            {
               layout_hitArea.addChild(_loc4_);
               _loc2_--;
            }
            else
            {
               _loc3_++;
            }
         }
         if(text.layout_single_line.width != 0)
         {
            text.layout_single_line.addChild(text.tf_single_line);
         }
         if(animation_hover.isCreated)
         {
            animation_hover.stop();
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(animation_back.isCreated)
         {
            if(text.flag_sprite == null || text.flag_sprite.graphics == null)
            {
               return;
            }
            if(param1 == "hover" || param1 == "down")
            {
               text.flag_sprite.playbackSpeed = 1;
               text.flag_sprite.stopOnFrame(text.flag_sprite.lastFrame);
            }
            else
            {
               text.flag_sprite.playbackSpeed = -1;
               text.flag_sprite.stopOnFrame(0);
            }
            return;
         }
         if(animation_hover != null && animation_hover.isCreated)
         {
            if(param1 == "hover" || param1 == "down")
            {
               animation_hover.playbackSpeed = 1;
               animation_hover.stopOnFrame(animation_hover.lastFrame);
            }
            else
            {
               animation_hover.playbackSpeed = -1;
               animation_hover.stopOnFrame(0);
            }
            return;
         }
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
         var _loc2_:* = null;
         icon.asset.initGuiClip(this);
         if(icon && icon.specialOffer)
         {
            _loc2_ = icon.specialOffer as PlayerSpecialOfferWithTimer;
            timer.start();
         }
         if(icon && tf_single_line && tf_single_line.graphics)
         {
            tf_single_line.text = Translate.translate(icon.iconLabelLocaleId);
         }
         graphics.dispatchEventWith("resize");
         graphics.dispatchEventWith("layoutDataChange");
         layout_hitArea.invalidate();
      }
   }
}
