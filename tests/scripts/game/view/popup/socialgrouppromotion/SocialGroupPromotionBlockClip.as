package game.view.popup.socialgrouppromotion
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import starling.core.Starling;
   
   public class SocialGroupPromotionBlockClip extends ClipButton
   {
       
      
      private var hideHoverText:Boolean = true;
      
      private var hoverTextNaturalHeight:Number;
      
      public var button_close:ClipButton;
      
      public var text_underlined:ClipTextUnderlined;
      
      public var tf_hover_text:ClipLabel;
      
      public var layout_text:ClipLayout;
      
      public var image_icon:GuiClipImage;
      
      public var bg:GuiClipScale9Image;
      
      private var _hoverTextVisibility:Number = 0;
      
      public function SocialGroupPromotionBlockClip()
      {
         text_underlined = new ClipTextUnderlined();
         tf_hover_text = new ClipLabel(true);
         layout_text = ClipLayout.verticalMiddleCenter(0,text_underlined,tf_hover_text);
         super();
      }
      
      public function dispose() : void
      {
         Starling.juggler.removeTweens(this);
      }
      
      public function get hoverTextVisibility() : Number
      {
         return _hoverTextVisibility;
      }
      
      public function set hoverTextVisibility(param1:Number) : void
      {
         _hoverTextVisibility = param1;
         if(tf_hover_text)
         {
            tf_hover_text.height = !!hoverTextNaturalHeight?hoverTextNaturalHeight * param1:0;
            tf_hover_text.alpha = param1;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_hover_text.text = "!";
         tf_hover_text.validate();
         hoverTextNaturalHeight = tf_hover_text.height;
         tf_hover_text.text = "";
         if(hideHoverText)
         {
            hoverTextVisibility = 0;
         }
         button_close.graphics.visible = false;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         super.setupState(param1,param2);
         var _loc3_:Boolean = param1 == "hover" || param1 == "down";
         button_close.graphics.visible = _loc3_;
         if(hideHoverText)
         {
            if(_loc3_)
            {
               Starling.juggler.removeTweens(this);
               Starling.juggler.tween(this,0.3,{
                  "hoverTextVisibility":1,
                  "transition":"easeOut"
               });
            }
            else
            {
               Starling.juggler.removeTweens(this);
               Starling.juggler.tween(this,0.3,{
                  "hoverTextVisibility":0,
                  "transition":"easeOut"
               });
            }
         }
      }
      
      public function resize() : void
      {
         var _loc1_:int = 0;
         tf_hover_text.validate();
         var _loc2_:int = Math.ceil(Math.max(text_underlined.graphics.width,tf_hover_text.width));
         layout_text.width = _loc2_;
         if(bg)
         {
            if(button_close)
            {
               _loc1_ = button_close.graphics.x - bg.graphics.width;
            }
            bg.graphics.width = Math.ceil(layout_text.x + _loc2_ + image_icon.graphics.x);
            if(button_close)
            {
               button_close.graphics.x = bg.graphics.width + _loc1_;
            }
         }
      }
   }
}
