package game.view.popup.clan.editicon
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipColoredImage;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class ClanIconClip extends GuiClipNestedContainer
   {
       
      
      private var icon:Image;
      
      public var front:ClipSprite;
      
      public var canvas:ClipColoredImage;
      
      public var layout_icon:ClipLayout;
      
      public var back:ClipSprite;
      
      public function ClanIconClip()
      {
         layout_icon = ClipLayout.horizontalMiddleCentered(0);
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function setupCanvas(param1:Texture, param2:uint, param3:uint) : void
      {
         canvas.image.colorPattern = param1;
         canvas.image.color1 = param2;
         canvas.image.color2 = param3;
      }
      
      public function setupIcon(param1:Texture, param2:uint) : void
      {
         var _loc3_:* = NaN;
         if(!icon)
         {
            icon = new Image(param1);
            layout_icon.addChild(icon);
         }
         else
         {
            icon.texture = param1;
         }
         if(layout_icon.width > 50)
         {
            _loc3_ = 1;
         }
         else if(layout_icon.width > 30)
         {
            _loc3_ = 0.6;
         }
         else
         {
            _loc3_ = 0.45;
         }
         icon.width = param1.width * _loc3_;
         icon.height = param1.height * _loc3_;
         layout_icon.invalidate();
         layout_icon.validate();
         icon.color = param2;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
