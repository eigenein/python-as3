package game.view.popup.shop.clanwar
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.RotatingGlowImageFilter;
   import game.view.gui.components.toggle.ClipToggleButton;
   
   public class ClanWarShopUpperTab extends ClipToggleButton
   {
       
      
      public var bg:GuiClipScale9Image;
      
      public var bg_selected:GuiClipScale9Image;
      
      public var animation_highlight:GuiClipScale9Image;
      
      public var tf_text:ClipLabel;
      
      public var tf_text_selected:ClipLabel;
      
      public var layout_text:ClipLayout;
      
      public function ClanWarShopUpperTab()
      {
         bg = new GuiClipScale9Image();
         bg_selected = new GuiClipScale9Image();
         animation_highlight = new GuiClipScale9Image();
         tf_text = new ClipLabel();
         tf_text_selected = new ClipLabel();
         layout_text = ClipLayout.horizontalMiddleCentered(0,tf_text,tf_text_selected);
         super();
      }
      
      public function get width() : Number
      {
         return bg_selected.graphics.width;
      }
      
      public function set width(param1:Number) : void
      {
         var _loc3_:Number = bg.graphics.width - bg_selected.graphics.width;
         var _loc2_:Number = tf_text.graphics.width - bg_selected.graphics.width;
         bg_selected.graphics.width = param1;
         bg.graphics.width = param1 + _loc3_;
         tf_text.graphics.width = param1 + _loc2_;
         tf_text_selected.graphics.width = param1 + _loc2_;
         layout_text.graphics.width = param1 + _loc2_;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(animation_highlight.graphics)
         {
            animation_highlight.graphics.blendMode = "add";
            animation_highlight.graphics.filter = new RotatingGlowImageFilter();
            animation_highlight.graphics.visible = false;
         }
         bg_selected.graphics.width = bg_selected.graphics.width - 4;
         bg.graphics.width = bg.graphics.width - 4;
      }
      
      override protected function updateViewState() : void
      {
         var _loc1_:Boolean = this.isSelected;
         bg_selected.graphics.visible = _loc1_;
         tf_text.visible = !_loc1_;
         tf_text_selected.visible = _loc1_;
      }
   }
}
