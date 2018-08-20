package game.view.popup.common.resourcepanel
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.SpecialClipLabel;
   
   public class PopupResourcePanelTooltipViewClip extends GuiClipNestedContainer
   {
       
      
      public var tf_text:SpecialClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public function PopupResourcePanelTooltipViewClip()
      {
         tf_text = new SpecialClipLabel(true);
         bg = new GuiClipScale9Image(new Rectangle(16,16,16,16));
         super();
      }
   }
}
