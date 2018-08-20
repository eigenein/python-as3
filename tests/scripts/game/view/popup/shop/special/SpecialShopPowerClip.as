package game.view.popup.shop.special
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   
   public class SpecialShopPowerClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public var tf_value:ClipLabel;
      
      public var powerIconRays_inst0:ClipSprite;
      
      public var bg:GuiClipScale9Image;
      
      public function SpecialShopPowerClip()
      {
         tf_label = new ClipLabel();
         tf_value = new ClipLabel();
         powerIconRays_inst0 = new ClipSprite();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
