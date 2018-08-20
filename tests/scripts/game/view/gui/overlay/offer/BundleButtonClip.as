package game.view.gui.overlay.offer
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.context.GameContext;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.IGuiClip;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import starling.filters.ColorMatrixFilter;
   
   public class BundleButtonClip extends SideBarButton
   {
       
      
      public var tf_single_line:ClipLabel;
      
      public var tf_single_line_14:ClipLabel;
      
      public var tf_time:SpecialClipLabel;
      
      public var tf_txt_line_1:ClipLabel;
      
      public var tf_txt_line_2:ClipLabel;
      
      public var flag_sprite:ClipSprite;
      
      public var icon_tmp:GuiAnimation;
      
      public var text:BundleButtonTextBlockClip;
      
      public var animation_back:GuiAnimation;
      
      public var animation_front:GuiAnimation;
      
      public function BundleButtonClip()
      {
         tf_single_line = new ClipLabel();
         tf_single_line_14 = new ClipLabel();
         tf_time = new SpecialClipLabel();
         tf_txt_line_1 = new ClipLabel();
         tf_txt_line_2 = new ClipLabel();
         flag_sprite = new ClipSprite();
         icon_tmp = new GuiAnimation();
         text = new BundleButtonTextBlockClip();
         animation_back = new GuiAnimation();
         animation_front = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc4_:int = 0;
         super.setNode(param1);
         var _loc3_:Vector.<IGuiClip> = new <IGuiClip>[animation_back,icon_tmp,flag_sprite,tf_single_line,tf_single_line_14,tf_time,tf_txt_line_1,tf_txt_line_2,text,animation_front];
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(!(_loc3_[_loc4_] is GuiAnimation) || (_loc3_[_loc4_] as GuiAnimation).isCreated)
            {
               layout_hitArea.addChild(_loc3_[_loc4_].graphics);
            }
            _loc4_++;
         }
         if(animation_back.isCreated)
         {
            if(GameContext.instance.localeID == "en" || GameContext.instance.localeID == "es")
            {
               if(text.tf_txt_line_1.width != 0)
               {
                  text.tf_txt_line_1.text = Translate.translate("UI_BUNDLE_LINE_1");
                  text.tf_txt_line_2.text = Translate.translate("UI_BUNDLE_LINE_2");
                  text.tf_single_line.graphics.visible = false;
                  text.tf_single_line_14.visible = false;
               }
               else
               {
                  text.tf_single_line_14.text = Translate.translate("UI_BUNDLE_LINE_0");
                  text.tf_txt_line_1.visible = false;
                  text.tf_txt_line_2.visible = false;
                  text.tf_single_line.visible = false;
               }
            }
            else
            {
               text.tf_single_line.text = Translate.translate("UI_BUNDLE_LINE_0");
               text.tf_single_line.adjustSizeToFitWidth();
               text.tf_txt_line_1.visible = false;
               text.tf_txt_line_2.visible = false;
               text.tf_single_line_14.visible = false;
            }
         }
         else if(GameContext.instance.localeID == "en")
         {
            if(tf_txt_line_1.width != 0)
            {
               tf_txt_line_1.text = Translate.translate("UI_BUNDLE_LINE_1");
               tf_txt_line_2.text = Translate.translate("UI_BUNDLE_LINE_2");
               tf_single_line.graphics.visible = false;
               tf_single_line_14.visible = false;
            }
            else
            {
               tf_single_line_14.text = Translate.translate("UI_BUNDLE_LINE_0");
               tf_txt_line_1.visible = false;
               tf_txt_line_2.visible = false;
               tf_single_line.visible = false;
            }
         }
         else
         {
            tf_single_line.text = Translate.translate("UI_BUNDLE_LINE_0");
            tf_txt_line_1.visible = false;
            tf_txt_line_2.visible = false;
            tf_single_line_14.visible = false;
         }
      }
      
      override public function updateTime(param1:String) : void
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
   }
}
